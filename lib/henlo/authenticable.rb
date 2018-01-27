require "henlo/helpers/util"
module Henlo::Authenticable
    
  def self.parse_token_type(token)
    begin 
      claim = Knock::AuthToken.new(token: token).payload
    rescue JWT::ExpiredSignature
      it_expired(token)
    end 
    puts ":claim in parse_token_type is #{claim}"
    claim["type"]
  end 
  
  def self.it_suspicious?(resource)
    true unless resource.check_blacklist?    
  end 

  def self.it_not_fren?(resource)
    BlacklistedToken.where(token_jti: resource.refresh_token_jti)
  end 

  def self.parse_resource(payload, model)
    puts "running"
    puts payload
    model.capitalize.constantize.find(payload["sub"])
  end 

  def self.it_me?(token, model )
    type = parse_token_type(token)
    puts "type is #{type}"
    puts Knock::AuthToken.new(token: token).inspect
    payload = Knock::AuthToken.new(token: token).payload
    puts payload
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