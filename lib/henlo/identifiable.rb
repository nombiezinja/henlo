module Henlo::Identifiable

  def self.generate_identifiable(user, env)
    exp = env == 'production' ? Time.now.utc.to_i + Henlo.id_token_lifetime : nil 
    Knock::AuthToken.new(payload: {user_id: user.id, device_id: 'device1', exp: nil}).token
  end 

end 