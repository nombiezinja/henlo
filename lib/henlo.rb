require "henlo/version"
require "henlo/refreshable"
require "henlo/identifiable"
require "henlo/engine"


module Henlo
  
  def self.generate_henlo(user, options={})
    env = options[:env] || ENV['RAILS_ENV'] 
    henlo = Hash[
      id_token: Identifiable.generate_identifiable(user)
    ]
    henlo[:refresh_token] = Refreshable.generate_refreshable(user) unless env == 'development'
    henlo 
  end 

end
