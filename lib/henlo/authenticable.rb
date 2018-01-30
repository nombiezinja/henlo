require "henlo/helpers/util"
require 'active_record/errors'
#
## Module
module Henlo::Authenticable
  
  #
  ## Retrieve the token type from the jwt payload 
  def self.parse_token_type(token, options={})
    claim = Knock::AuthToken.new(token: token, verify_options: options).payload
    claim["type"]
  end 
  
  #
  ## Match the token jwt identifier with what is stored in the database for the resource,
  ## a lack of match indicates suspicious activities
  def self.jti_match?(payload, resource)
    payload["jti"] === resource.refresh_token_jti
  end 
  
  #
  ## Check the resource to see if it has been flagged for blacklist check 
  def self.it_suspicious?(resource)
    resource.blacklist_check?    
  end 

  #
  ## Check the blacklisted tokens table to see whether the token's jwt identifier has been
  ## blacklisted
  def self.it_not_fren?(resource)
    BlacklistedToken.where(token_jti: resource.refresh_token_jti).first
  end 
  
  #
  ## Parse the resource as identified by the id encoded in the jwt with the key "sub" 
  def self.parse_resource(payload, model)
    resource = model.capitalize.constantize.where(id: payload["sub"]).first
    if resource.nil? 
      raise ActiveRecord::RecordNotFound
    end
    resource
  end 
  
  #
  ## Authenticates resource by first determining the treatment based on the type of token. 
  ## Requests with valid id tokens will be processed. 
  ## Requests with refresh tokens will be checked for 1) whether the resource has been flagged
  ## for blacklist check and if yes, 2) whether the token's jwt identifier has been flaglisted.
  ## If neither 1) nor 2) is established, the token will be checked for a match of the jwt identifier
  ## The resource is returned if all these checks are passed.
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
        if jti_match?(payload, resource)
          resource
        else 
          Henlo::Revocable.token_blockt(payload, resource)
          nil 
        end       
      end 
    else 
      nil 
    end 
  end 
  
  #
  ## This method is to be called before `it_me?` is called, so that expired tokens are treated before
  ## the authentication begins. Requests made with expired id tokens are rejected with an error. 
  ## Requests made with expired refresh tokens are then processed with "reauthentication_strategy. 
  ## This method is passed as an argument to `it_expired` by the app. You can define how 
  ## users are reauthenticated in your own app.  
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