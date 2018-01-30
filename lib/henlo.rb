require "henlo/version"
require "henlo/refreshable"
require "henlo/identifiable"
require "henlo/authenticable"
require "henlo/revocable"
require "knock"

module Henlo

  # include Knock::Authenticable
  
  def self.generate_henlos(options={})
    claim = options || nil 
    refresh_token_and_jti = Refreshable.generate_refreshable(options) 
    id_token_and_exp = Identifiable.generate_identifiable(options)
    tokens = Hash[
      id_token: id_token_and_exp[:token],
      refresh_token: refresh_token_and_jti[:token]
    ]
    henlos = Hash[
      tokens: tokens, 
      jti: refresh_token_and_jti[:jti],
      exp: id_token_and_exp[:exp]
    ]
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

