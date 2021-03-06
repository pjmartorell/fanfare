class Order < ActiveRecord::Base
  include AASM

  STATES = %w{ pending paid given no_stock sent rejected}

  belongs_to :user

  before_validation :set_ref, :on => :create
  validates_inclusion_of :state, :in => STATES

  scope :newest_first, -> { order('id DESC') }
  scope :shipping_country, -> (shipping_country) { where shipping_country: shipping_country }

  aasm :column => :state do
    state :pending, :initial => true
    state :paid, :after_enter => [:update_stock, :notify_payment]
    state :given, :enter => :give_prize
    state :no_stock, :enter => :notify_no_stock
    state :sent, :enter => :notify_shipment
    state :rejected, :enter => :notify_rejection

    event :set_paid do
      transitions :to => :paid, :from => :pending, :guards => :is_product_order?
    end

    event :set_given do
      transitions :to => :given, :from => :pending, :guards => :is_prize_order?
    end

    event :set_no_stock do
      transitions :to => :no_stock, :from => :paid, :guards => :is_product_order?
    end

    event :set_sent do
      transitions :to => :sent, :from => [:paid, :given, :no_stock]
    end

    event :set_rejected do
      transitions :to => :rejected, :from => [:pending, :paid, :sent, :given]
    end
  end

  private

  def is_product_order?
    instance_of?(ProductOrder)
  end

  def is_prize_order?
    instance_of?(PrizeOrder)
  end

  def notify_shipment
  end

  def notify_rejection
  end

  def set_ref
    return unless user.present?
    self.ref = calculate_ref
  end
end