class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string, :default => "user"
  end

  def down
    remove_column :users, :role
  end
end
