class AddSystemToEnvironment < ActiveRecord::Migration
  def change
    add_column :environments, :system, :number
  end
end
