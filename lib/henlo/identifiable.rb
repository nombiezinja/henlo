require "henlo/helpers/util"

module Henlo::Identifiable

  def self.generate_identifiable(model, options={})
    claim = options || nil 
   
    claim.merge!({
      exp: Time.now.utc.to_i + Henlo.id_token_lifetime, 
      jti: Henlo::Helpers::Util.generate_jti,
      type: "id"
    })

    Hash[
      token: Knock::AuthToken.new(payload: claim).token, 
      exp: claim[:exp]       
    ]

  end 

  def self.it_id_token?(token)
    true 
  end 
  
  def self.it_expired?(token)
    claim = Knock::AuthToken.new(token: token).payload
    claim.exp > Time.now.utc.to_i 
  end
  

end 