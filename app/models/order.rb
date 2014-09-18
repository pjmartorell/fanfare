class Order < ActiveRecord::Base
  SHIPPING_COUNTRIES = ['Spain']

  has_many :order_products
  has_many :products, :through => :order_products
  belongs_to :user

  accepts_nested_attributes_for :order_products

  before_validation :set_ref, :on => :create
  before_validation :set_price, :on => :create
  before_validation :set_bonus_points, :on => :create

  ["bonus_points", "price"].each do |attr|
    define_method "calculate_#{attr}" do
      order_products.map do |order_product|
        order_product.quantity * order_product.product.send(attr)
      end.sum
    end
  end

  private

  def set_price
    self.price = calculate_price.round(2)
  end

  def set_bonus_points
    self.bonus_points = calculate_bonus_points
  end

  def set_ref
    return unless user.present?
    self.ref = calculate_ref
  end

  def calculate_ref
    [Time.now.strftime("%Y%m"), user.id, user.orders.count].join
  end
end