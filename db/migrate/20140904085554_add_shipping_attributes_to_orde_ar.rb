class AddShippingAttributesToOrdeAr < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_name, :string
    add_column :orders, :shipping_last_name, :string
    add_column :orders, :shipping_address, :string
    add_column :orders, :shipping_town, :string
    add_column :orders, :shipping_zip, :string
    add_column :orders, :shipping_province, :string
    add_column :orders, :shipping_country, :string
    add_column :orders, :shipping_phone, :string
  end
end
