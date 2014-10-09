class ProductOrder < Order
  SHIPPING_COUNTRIES = ['ES', 'PT', 'IT', 'DE']

  has_many :order_products, -> { order('created_at ASC') }, dependent: :destroy, :foreign_key => "order_id"
  has_many :products, :through => :order_products

  accepts_nested_attributes_for :order_products

  before_validation :set_price, :on => :create
  before_validation :set_bonus_points, :on => :create
  validates_inclusion_of :shipping_country, :in => SHIPPING_COUNTRIES

  ["bonus_points", "price"].each do |attr|
    define_method "calculate_#{attr}" do
      order_products.map do |order_product|
        order_product.quantity * order_product.product.send(attr)
      end.sum
    end
  end

  scope :newest_first, -> { order('id DESC') }
  scope :product_order, -> (product_order_id) { where product_order_id: product_order_id }
  scope :shipping_country, -> (shipping_country) { where shipping_country: shipping_country }
  scope :state, -> (state) { where state: state }

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