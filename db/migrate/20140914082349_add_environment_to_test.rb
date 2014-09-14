class AddEnvironmentToTest < ActiveRecord::Migration
  def change
    add_column :tests, :environment, :number
  end
end
