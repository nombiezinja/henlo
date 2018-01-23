module Henlo::Identifiable

  def generate_identifiable
    puts "identifiable running"
    Knock::AuthToken.new(payload: {user_id: 3, device_id: 'device1'}).token
  end 

end 