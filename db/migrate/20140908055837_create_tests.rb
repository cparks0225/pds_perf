class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :name
      t.text :queries

      t.timestamps
    end
  end
end
