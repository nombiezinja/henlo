require "henlo/helpers/util"

module Henlo::Identifiable

  def self.generate_identifiable(model, options={})
    claim = options || nil 
   
    exp = Time.now.utc.to_i + Henlo.id_token_lifetime 
    jti = Henlo::Helpers::Util.generate_jti
   
    claim[:jti] = jti 
    claim[:exp] = exp 
   
    Knock::AuthToken.new(payload: claim).token
  end 
 
end 