class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :name
      t.text :queries
      t.integer :system
      t.boolean :can_delete

      t.timestamps
    end
  end
end
