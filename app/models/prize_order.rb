class PrizeOrder < Order
  include ActiveModel::Validations

  SHIPPING_COUNTRIES = ['ES', 'DE']
  PRIORITY_SHIPPING_COUNTRIES = ['ES', 'PT', 'IT', 'US']

  # attr_accessible :user_id, :prize_id, :id_card, :birth_date,
  #   :prize_name, :prize_points, :shipping_name, :shipping_phone,
  #   :shipping_last_name, :shipping_address, :shipping_town,
  #   :shipping_zip, :shipping_province, :shipping_country,
  #   :shipping_email, :comment, :note

  validates_inclusion_of :shipping_country, :in => SHIPPING_COUNTRIES, :if => Proc.new{|f| f.is_physical?}
  validates_presence_of :shipping_email, :if => "prize.paypal?"
  validates_presence_of :user_id, :prize_id, :birth_date,
  :id_card, :prize_name, :prize_points
  validates_presence_of :shipping_name, :shipping_phone,
  :shipping_last_name, :shipping_address, :shipping_town,
  :shipping_zip, :shipping_province, :shipping_country

  validates_inclusion_of :shipping_country, :in => SHIPPING_COUNTRIES, :if => Proc.new{|f| f.is_physical?}

  after_create :deduct_points!
  after_commit :report_and_notify_prize_order, :on => :create

  scope :prize, -> (prize_id) { where prize_id: prize_id }

  belongs_to :user
  belongs_to :prize

  private

  def give_prize
  end

  def deduct_points!
    movement = user.edit_points!(UserPoints::RECHARGING_POINTS - user.user_points.points, "Prize ordered", self)
    update_attribute(:points_movement_id, movement.id)
  end

  def report_and_notify_prize_order
    BackgroundSystem.enqueue(PrizeOrderedNotifierWorker, id)
    BackgroundSystem.enqueue(PrizeOrdererWorker, id)
  end

  def calculate_ref
    [Time.now.strftime("%Y%m"), user.id, user.prize_orders.count].join
  end

  def update_user_data
    user.shipping_email = shipping_email
    user.first_name = shipping_name
    user.last_name = shipping_last_name
    user.save
  end
end