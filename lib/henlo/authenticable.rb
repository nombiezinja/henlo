require "henlo/helpers/util"
require 'active_record/errors'

module Henlo::Authenticable
    
  def self.parse_token_type(token, options={})
    claim = Knock::AuthToken.new(token: token, verify_options: options).payload
    claim["type"]
  end 
  
  def self.it_suspicious?(resource)
    resource.blacklist_check?    
  end 

  def self.it_not_fren?(resource)
    BlacklistedToken.where(token_jti: resource.refresh_token_jti).first
  end 

  def self.parse_resource(payload, model)
    resource = model.capitalize.constantize.where(id: payload["sub"]).first
    if resource.nil? 
      raise ActiveRecord::RecordNotFound
    end
    resource
  end 

  def self.it_me?(token, model)
    type = parse_token_type(token)
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

  def self.it_expired(reauthenticate_strategy, token, model)
    token = Knock::AuthToken.new(token: token, verify_options: {verify_expiration: false}).token
    claim = Knock::AuthToken.new(token: token, verify_options: {verify_expiration: false}).payload
    resource = parse_resource(claim, model)
    if claim["type"] == "id"
      raise ActionController::InvalidAuthenticityToken 
    else 
      reauthenticate_strategy
    end    
  end 
end 