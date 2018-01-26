require "henlo/helpers/util"

module Henlo::Authenticatable
  
  def self.parse_token_type(token)
    Knock::AuthToken.new(token: token).payload.type
  end 
  
  def it_me?()
    begin 
      token_type = parse_token_type(token_from_request_headers)
      case token_type 
      when 'id'
        super 
      when 'refresh'
        refresh_henlos
      else
        render_401 
      end 
    rescue JWT::ExpiredSignature
      Henlo::Refreshable.jwt_expired
    end 
  end 
  

end 