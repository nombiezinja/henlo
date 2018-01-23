  <%
  parent_class = ActiveRecord::Migration
  parent_class = parent_class[parent_class.current_version] if Rails::VERSION::MAJOR >= 5
-%>
class AddJtiColumnTo<%= table_name.camelize %>s < <%= parent_class.to_s %>
  def self.up
    change_table(:<%= table_name.downcase %>s) do |t|
<%= migration_data %>
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end