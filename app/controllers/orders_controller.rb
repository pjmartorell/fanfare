class OrdersController < ApplicationController
  load_resource

  def new
    @order = Order.new(:user_id => current_user.id)

    @products = Product.visible.all
    @products.each do |product|
      @order.order_products.build(:product_id => product.id, :quantity => 0)
    end
  end

  def create
    if params[:order]
      params_order = purge_null_products(params[:order])
      @order = Order.new order_params
      @order.user = current_user

      if @order.save
        redirect_to finalize_order_path(@order)
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  def finalize
    redirect_to root_path if @order.paid
  end

  private

  def purge_null_products(params_order)
    params_order[:order_products_attributes] = params_order[:order_products_attributes].select do |k,v|
      v["quantity"].present? && v["quantity"].to_i > 0
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id, :price,
    {:order_products => [:order_id, :product_id]},
    :shipping_name, :shipping_last_name, :shipping_address,
    :shipping_town, :shipping_zip, :shipping_province,
    :shipping_country, :shipping_phone, :bonus_points,
    :paid, :ref)
  end
end
