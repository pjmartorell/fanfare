class Product < ActiveRecord::Base
  has_many :order_products
  has_many :product_orders, :through => :order_products

  scope :visible, -> { where(:visible => true) }

  validates_presence_of :name, :price, :bonus_points
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0

  mount_uploader :product_index_image, ProductImageUploader
  mount_uploader :product_show_image, ProductShowImageUploader
end