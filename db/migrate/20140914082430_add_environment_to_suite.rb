class AddEnvironmentToSuite < ActiveRecord::Migration
  def change
    add_column :suites, :environment, :integer
  end
end
