require 'rails/generators/base'

module Henlo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Installs Henlo."
      argument :name, type: :string, default: "User"


      def copy_initializer
        template "henlo_initializer.rb", "config/initializers/henlo.rb"

        puts "Installation complete."
      end
      
    end
  end
end