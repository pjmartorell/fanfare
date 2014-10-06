class AddProductOrderIdToOrderProduct < ActiveRecord::Migration
  def up
    add_column :order_products, :product_order_id, :integer
    remove_column :order_products, :order_id

  end

  def down
    add_column :order_products, :order_id, :integer
    remove_column :order_products, :product_order_id
  end
end
