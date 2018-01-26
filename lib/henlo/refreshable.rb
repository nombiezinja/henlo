require "henlo/helpers/util"

module Henlo::Refreshable

  def self.generate_refreshable(model, options={})
    claim = options || nil 
    
    exp = Time.now.utc.to_i + Henlo.refresh_token_lifetime
    jti = Henlo::Helpers::Util.generate_jti
    
    claim[:exp] = exp
    claim[:jti] = jti 
    claim[:type] = "refresh"
    
    Hash[
      token: Knock::AuthToken.new(payload: claim).token, 
      jti: jti       
    ]
  end 

end 