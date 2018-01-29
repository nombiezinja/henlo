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
    BlacklistedToken.where(token_jti: resource.refresh_token_jti).first
  end 

  def self.parse_resource(payload, model)
    model.capitalize.constantize.find(payload["sub"])
  end 

  def self.it_me?(token, model )
    type = parse_token_type(token)
    payload = Knock::AuthToken.new(token: token).payload
    resource = parse_resource(payload, model)
    case type 
    when "id"
      Rails::ApplicationController.verify_user
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

  def self.it_expired(reauthenticate_strategy, token)
    begin 
      type = parse_token_type(token)
    rescue JWT::ExpiredSignature
      raise ActionController::InvalidAuthenticityToken
    end 
    
    reauthenticate_strategy unless type == "id"
  end 

end 