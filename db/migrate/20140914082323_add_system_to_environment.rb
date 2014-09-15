class AddSystemToEnvironment < ActiveRecord::Migration
  def change
    add_column :environments, :system, :integer
  end
end
