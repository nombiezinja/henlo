module Henlo::Revocable 
  
  def self.token_blockt(payload, resource)
    resource.blacklist_check == true
    resource.save!
    
    blacklisted_token = BlacklistedToken.create(
      token_jti: payload["jti"],
      exp_in_unix: payload["exp"]
    )
  end 

  def self.token_rekt
    BlacklistedToken.each do |token|
      token.destroy unless Time.now.utc < token.exp_in_unix 
    end   
  end

end 