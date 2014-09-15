class AddSystemToSuite < ActiveRecord::Migration
  def change
    add_column :suites, :system, :integer
  end
end
