class AddEnvironmentToTest < ActiveRecord::Migration
  def change
    add_column :tests, :environment, :integer
  end
end
