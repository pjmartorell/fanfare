class ProductOrder < Order
  SHIPPING_COUNTRIES = ['Spain']

  has_many :order_products
  has_many :products, :through => :order_products

  accepts_nested_attributes_for :order_products

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

  def calculate_ref
    [Time.now.strftime("%Y%m"), user.id, user.product_orders.count].join
  end

  def update_user_data
    user.shipping_name = shipping_name
    user.shipping_last_name = shipping_last_name
    user.shipping_address = shipping_address
    user.shipping_town = shipping_town
    user.shipping_zip = shipping_zip
    user.shipping_province = shipping_province
    user.shipping_country = shipping_country
    user.shipping_phone = shipping_phone
    user.save
  end
end