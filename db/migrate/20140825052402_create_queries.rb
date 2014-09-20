class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :method
      t.text :url
      t.text :data
      t.integer :system
      t.boolean :can_delete

      t.timestamps
    end
  end
end
