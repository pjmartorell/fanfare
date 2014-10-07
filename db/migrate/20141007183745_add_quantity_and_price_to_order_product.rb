class AddQuantityAndPriceToOrderProduct < ActiveRecord::Migration
  def change
    add_column :order_products, :order_id, :integer
    add_column :order_products, :price, :decimal, :precision => 8, :scale => 2

    remove_column :order_products, :product_order_id, :integer

    add_index :order_products, ["order_id"], :name => "index_order_product_on_order_id"
    add_index :order_products, ["product_id"], :name => "index_order_product_on_product_id"
  end
end
