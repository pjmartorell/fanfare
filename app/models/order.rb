class Order < ActiveRecord::Base
  include AASM

  belongs_to :user

  before_validation :set_ref, :on => :create
  after_create :update_user_data

  aasm :column => :state do
    state :pending, :initial => true
    state :undecided
    state :given, :enter => :give_prize
    state :sent, :enter => :notify_shipment
    state :rejected, :enter => :notify_rejection

    event :set_undecided do
      transitions :to => :undecided, :from => :pending
    end

    event :set_given do
      transitions :to => :given, :from => [:pending, :undecided]
    end

    event :set_sent do
      transitions :to => :sent, :from => :given
    end

    event :set_rejected do
      transitions :to => :rejected, :from => [:undecided, :pending, :given, :sent]
    end
  end

  private

  def give_prize
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