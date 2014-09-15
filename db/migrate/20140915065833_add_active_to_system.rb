class AddActiveToSystem < ActiveRecord::Migration
  def change
    add_column :systems, :active, :boolean
  end
end
