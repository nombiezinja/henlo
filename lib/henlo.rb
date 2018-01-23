require "henlo/version"
require "henlo/refreshable"
require "henlo/identifiable"
# require "henlo/engine"


module Henlo
  
  def self.generate_henlo(user, options={})
    claim = options || nil 
    henlo = Hash[
      id_token: Identifiable.generate_identifiable(user, options),
      refresh_token: Refreshable.generate_refreshable(user) 
    ]
  end 

  mattr_accessor :refresh_token_lifetime
  self.refresh_token_lifetime = 15
   
  mattr_accessor :id_token_lifetime
  self.id_token_lifetime = 60 * 15

  # Default way to setup Henlo. Run `rails generate henlo:install` to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end


end

