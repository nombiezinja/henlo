module Henlo::Identifiable

  def self.generate_identifiable(model, options={})
    exp = Time.now.utc.to_i + Henlo.id_token_lifetime 
    claim = options || nil 
    claim[:exp] = exp 
    Knock::AuthToken.new(payload: claim).token
  end 

end 