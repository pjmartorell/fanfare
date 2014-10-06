class OrderProduct < ActiveRecord::Base

  belongs_to :product_order
  belongs_to :product
end