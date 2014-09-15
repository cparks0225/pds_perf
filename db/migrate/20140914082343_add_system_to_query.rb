class AddSystemToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :system, :integer
  end
end
