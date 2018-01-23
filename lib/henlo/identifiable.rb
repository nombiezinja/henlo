module Henlo::Identifiable

  def self.generate_identifiable(user)
    Knock::AuthToken.new(payload: {user_id: user.id, device_id: 'device1', exp: Time.now.utc.to_i + 60 * 15}).token
  end 

end 