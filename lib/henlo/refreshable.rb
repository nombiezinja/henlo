module Henlo::Refreshable

  def self.generate_refreshable(user)
    exp = Time.now.utc.to_i + Henlo.refresh_token_lifetime
    Knock::AuthToken.new(payload: {user_id: user.id, device_id: 'device1', exp: exp}).token
  end 

end 