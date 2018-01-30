#
## Module allows the blacklist of tokens as identified by the jti (jwt identifier)
## Blacklisted refresh tokens cannot be used to generate new id tokens
module Henlo::Revocable 
  
  #
  ## Method called when the identifier as encoded in the token payload does not match what was stored in the database
  ## or when the revoke token route is called by the user in cases of breach such as device loss
  ## the token is blacklisted and the resource is flagged as needing blacklist checks
  def self.token_blockt(payload, resource)
    resource.blacklist_check == true
    resource.save!
    
    blacklisted_token = BlacklistedToken.create(
      token_jti: payload["jti"],
      exp_in_unix: payload["exp"]
    )
  end 
  
  #
  ## Call this period in a scheduled task to clean expired tokens from the database
  def self.token_rekt
    BlacklistedToken.each do |token|
      token.destroy unless Time.now.utc < token.exp_in_unix 
    end   
  end

end 