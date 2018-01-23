require 'rails/generators/active_record'

module Henlo
  module Generators
    class MigrationsGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Generates the necessary migration for the model"
      argument :table_name, type: :string, default: "User"


      def create_migrations
        puts "Generating migrations for model #{table_name}.downcase"
        migration_template "migrations/add_jti_column.rb", "db/migrate/add_jti_column_to_#{table_name.downcase}s.rb"
        migration_template 'migrations/create_blacklisted_tokens.rb.erb', 'db/migrate/create_blacklisted_tokens.rb'
      end

      def migration_data
<<RUBY
      t.string :refresh_token_jti 
RUBY
      end
      
    end
  end
end