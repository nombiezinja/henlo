require "henlo/version"
require "henlo/refreshable"
require "henlo/identifiable"
require "henlo/engine"


module Henlo
  
  def self.generate_henlo(user, options={})
    env = options[:env] || ENV['RAILS_ENV'] 
    henlo = Hash[
      id_token: Identifiable.generate_identifiable(user, env)
    ]
    henlo[:refresh_token] = Refreshable.generate_refreshable(user) unless env == 'development'
    henlo 
  end 

  mattr_accessor :refresh_token_lifetime
  self.refresh_token_lifetime = 15.days
   
  mattr_accessor :id_token_lifetime
  self.id_token_lifetime = 60 * 15

  # Default way to setup Henlo. Run `rails generate henlo:install` to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end


end

