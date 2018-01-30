
#
## Helper methods 
module Henlo 
  module Helpers 
    module Util 
      
      #
      ## Generates a random string in the format of "a5391f26-1136-46f3-a3d3-ea4e1e558f06"
      ## to use as a unique jwt identifier. 
      def self.generate_jti 
        SecureRandom.uuid
      end 

    end 
  end 
end 