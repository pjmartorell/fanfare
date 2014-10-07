class OrderProduct < ActiveRecord::Base

  belongs_to :order
  belongs_to :product

  before_validation :copy_price
  before_validation :copy_bonus_points

  validates :product, presence: true
  validates :quantity, numericality: {
    only_integer: true,
    greater_than: -1,
    message: "Ha de ser una quantitat entera"
  }
  validates :price, numericality: true

  ["bonus_points", "price"].each do |attr|
    define_method "#{attr}_amount" do
      read_attribute(attr) * quantity
    end
  end

  private

    def copy_price
      self.price = product.price
    end

    def copy_bonus_points
      self.bonus_points = product.bonus_points
    end
end