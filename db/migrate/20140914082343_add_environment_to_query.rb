class AddEnvironmentToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :environment, :integer
  end
end
