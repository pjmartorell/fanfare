class Admin::OrdersController < Admin::AdminController

  def index
    @orders = Order.all
  end

  def toggle_sent
    @order.toggle!(:sent)
    redirect_to :back
  end
end
