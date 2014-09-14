class AddEnvironmentToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :environment, :number
  end
end
