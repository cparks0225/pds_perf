class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.text :riskapi
      t.text :pds
      t.text :token

      t.timestamps
    end
  end
end
