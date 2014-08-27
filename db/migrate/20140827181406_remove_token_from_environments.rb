class RemoveTokenFromEnvironments < ActiveRecord::Migration
  def change
    remove_column :environments, :token, :text
  end
end
