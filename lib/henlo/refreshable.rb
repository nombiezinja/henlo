module Henlo::Refreshable

  def self.generate_refreshable(user)
    Knock::AuthToken.new(payload: {user_id: user.id, device_id: 'device1', exp: Time.now.utc.to_i + 86400 * 180}).token
  end 

end 