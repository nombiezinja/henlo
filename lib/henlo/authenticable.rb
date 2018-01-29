require "henlo/helpers/util"
module Henlo::Authenticable
    
  def self.parse_token_type(token)
    claim = Knock::AuthToken.new(token: token).payload
    claim["type"]
  end 
  
  def self.it_suspicious?(resource)
    resource.blacklist_check?    
  end 

  def self.it_not_fren?(resource)
    BlacklistedToken.where(token_jti: resource.refresh_token_jti)
  end 

  def self.parse_resource(payload, model)
    model.capitalize.constantize.find(payload["sub"])
  end 

  def self.it_me?(token, model )
    begin 
      # claim = Knock::AuthToken.new(token: token).payload
      type = parse_token_type(token)
    rescue JWT::ExpiredSignature
      it_expired(token)
    end 
    payload = Knock::AuthToken.new(token: token).payload
    resource = parse_resource(payload, model)
    case type 
    when "id"
      resource
    when "refresh"
      if it_suspicious?(resource) && it_not_fren?(resource)
        nil
      else 
        resource      
      end 
    else 
      nil 
    end 
  end 

  def self.it_expired(token_type)
    if token_type == 'refresh'
      # verify_user
      puts "verify_user here"
    else
      raise ActionController::InvalidAuthenticityToken 
    end 
  end 

end 