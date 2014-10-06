class AddTypeAndStateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :type, :string
    add_column :orders, :state, :string
  end
end
