class Admin::ProductOrdersController < Admin::AdminController
  load_resource

  def index
  end

  def toggle_sent
    @product_order.toggle!(:sent)
    redirect_to :back
  end
end
