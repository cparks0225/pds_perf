class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.text :name

      t.timestamps
    end
  end
end
