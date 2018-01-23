module Henlo
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    desc "Creates a Henlo initializer."

    def copy_initializer
      template 'henlo.rb', 'config/initializers/henlo.rb'
    end
  end
end
