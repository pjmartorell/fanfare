class Admin::ProductOrdersController < Admin::AdminController
  load_resource
  before_filter :initialize_countries, :only => :show

  def index
    @states = Order::STATES
    @state = params[:state] || "pending"
    @shipping_countries = Carmen::Country.all
    @shipping_country = params[:shipping_country]
    @product_orders = @product_orders.pending if params[:state].blank?
    filtering_params(params).each do |key, value|
      @product_orders = @product_orders.public_send(key, value) if value.present?
    end

    @product_orders = @product_orders.newest_first.paginate(:page => params[:page], :per_page => 10)
  end

  def toggle_sent
    @product_order.toggle!(:sent)
    redirect_to :back
  end

  private

  def initialize_countries
    @shipping_countries = Carmen::Country.all.select{|c| ProductOrder::SHIPPING_COUNTRIES.include?(c.code)}
  end

  def filtering_params(params)
    params.slice(:shipping_country, :state)
  end
end
