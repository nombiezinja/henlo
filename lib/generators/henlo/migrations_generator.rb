require 'rails/generators/active_record'

module Henlo
  module Generators
    class MigrationsGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Generates the necessary migration for the model"
      argument :name, type: :string, default: "User"


      def create_migrations
        puts "Generating migrations."
        migration_template 'migrations/add_jti_column.rb.erb', 'db/migrate/add_jti_column.rb'
        migration_template 'migrations/create_blacklisted_tokens.rb.erb', 'db/migrate/create_blacklisted_tokens.rb'
      end
      
    end
  end
end