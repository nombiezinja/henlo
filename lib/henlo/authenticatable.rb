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
        reissue_tokens 
      else
        render_401 
      end 
    rescue JWT::ExpiredSignature
      if token_type == 'refresh'
        verify_user
      else
        raise ActionController::InvalidAuthenticityToken 
      end 
    end 
    
  end 
  

end 