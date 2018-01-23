module Henlo::Refreshable

  def self.say_henlo(name)
    puts "henlo #{name}"
  end 

  def self.generate_henlo(user)
    puts ENV['RAILS_ENV']
  end 

end 