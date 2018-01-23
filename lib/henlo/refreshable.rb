module Henlo::Refreshable

  def self.generate_refreshable(user)
    exp = Henlo.refresh_token_lifetime + Time.now.utc.to_i
    Knock::AuthToken.new(payload: {user_id: user.id, device_id: 'device1', exp: exp}).token
  end 

end 