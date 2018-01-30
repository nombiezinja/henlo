require "henlo/helpers/util"

#
## Module for generating refresh tokens

module Henlo::Refreshable
  
  #
  ## Generate refreshable token with a unix time for expiry, the type of token 
  ## and the jwt identifier (a random string) encoded in the payload in addition to 
  ## whatever was passed as payload when `generate_henlos` was called
  def self.generate_refreshable(options={})
    claim = options || nil 
    
    claim.merge!({
      exp: Time.now.utc.to_i + Henlo.refresh_token_lifetime, 
      jti: Henlo::Helpers::Util.generate_jti,
      type: "refresh"
    })
    
    Hash[
      token: Knock::AuthToken.new(payload: claim).token, 
      jti: claim[:jti]       
    ]
  end 

  #
  ## Store jwt identifier in the app's database, in the table of the resource  
  def self.store_jti(resource, jti)
    resource.update_attribute(:refresh_token_jti, jti)
  end 

end 