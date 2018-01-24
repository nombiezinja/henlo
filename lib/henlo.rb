require "henlo/version"
require "henlo/refreshable"
require "henlo/identifiable"
# require "henlo/engine"


module Henlo
  
  def self.generate_henlos(user, options={})
    claim = options || nil 
    refresh_token_and_jti = Refreshable.generate_refreshable(user) 
    tokens = Hash[
      id_token: Identifiable.generate_identifiable(user, options),
      refresh_token: refresh_token_and_jti[:token]
    ]
    henlos = Hash[
      tokens: tokens, 
      jti: refresh_token_and_jti[:jti]
    ]
  end
  
  def self.it_me?(access_token)
  end 

  mattr_accessor :refresh_token_lifetime
  self.refresh_token_lifetime = 15 * 86400
   
  mattr_accessor :id_token_lifetime
  self.id_token_lifetime = 60 * 15

  # Default way to setup Henlo. Run `rails generate henlo:install` to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end


end

