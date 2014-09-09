class AddProductIndexImageAndProductShowImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_show_image, :string
    add_column :products, :product_index_image, :string
  end
end
