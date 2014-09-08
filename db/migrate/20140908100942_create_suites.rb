class CreateSuites < ActiveRecord::Migration
  def change
    create_table :suites do |t|
      t.text :name
      t.text :tests

      t.timestamps
    end
  end
end
