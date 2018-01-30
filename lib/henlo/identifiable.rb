require "henlo/helpers/util"

#
## Generates id token. The id token is used to identify and authenticate the user before 
## responding to a request
module Henlo::Identifiable
  
  # Generates id token and returns both the token, with the optional payload encoded, and the
  ## token expiry time in unix seconds
  def self.generate_identifiable(options={})
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
 

end 