class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :method
      t.text :url
      t.text :data

      t.timestamps
    end
  end
end
