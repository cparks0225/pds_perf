class AddSystemToTest < ActiveRecord::Migration
  def change
    add_column :tests, :system, :integer
  end
end
