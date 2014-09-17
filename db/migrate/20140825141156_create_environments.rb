class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name
      t.string :riskapi
      t.string :pds
      t.integer :system
      t.boolean :active

      t.timestamps
    end
  end
end
