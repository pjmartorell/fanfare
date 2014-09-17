class AddRefToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :ref, :string
  end
end
