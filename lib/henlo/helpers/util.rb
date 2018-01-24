
module Henlo 
  module Helpers 
    module Util 

      def self.generate_jti 
        SecureRandom.uuid
      end 

    end 
  end 
end 