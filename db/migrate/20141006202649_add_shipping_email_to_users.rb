class AddShippingEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shipping_name, :string
    add_column :users, :shipping_last_name, :string
    add_column :users, :shipping_email, :string
    add_column :users, :shipping_address, :string
    add_column :users, :shipping_town, :string
    add_column :users, :shipping_zip, :string
    add_column :users, :shipping_province, :string
    add_column :users, :shipping_country, :string
    add_column :users, :shipping_phone, :string
  end
end
