require "henlo/helpers/util"

module Henlo::Refreshable

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
  
  def self.store_jti(resource, jti)
    resource.update_attribute(:refresh_token_jti, jti)
  end 

end 