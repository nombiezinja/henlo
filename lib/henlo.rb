require "henlo/version"
require "henlo/refreshable"
require "henlo/engine"


module Henlo

  # def self.included(base)
  #   base.extend ClassMethods
  # end
  
  def self.hi_there
    puts "this is a test"
  end 

  module ClassMethods

    def henlo_again 
      puts "henlo again"
    end 

  end 

end
