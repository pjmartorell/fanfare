class Product < ActiveRecord::Base
  has_many :order_products
  has_many :product_orders, :through => :order_products

  scope :visible, where(:visible => true)

  validates_presence_of :name, :price, :bonus_points

  mount_uploader :product_index_image, ProductImageUploader
  mount_uploader :product_show_image, ProductShowImageUploader
end