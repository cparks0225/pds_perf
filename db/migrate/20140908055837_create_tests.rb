class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :name
      t.text :queries
      t.integer :system

      t.timestamps
    end
  end
end
