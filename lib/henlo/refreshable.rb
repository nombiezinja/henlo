module Henlo::Refreshable

  def self.say_henlo(name)
    puts "henlo #{name}"
  end 
  
  def self.it_works 
    puts "it works"
  end 

  def self.generate_refreshable(user)
    puts Knock::AuthToken.new(payload: {user_id: 3, device_id: 'device1'}).token
    puts ENV['RAILS_ENV']
  end 

end 