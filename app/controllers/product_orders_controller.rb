class ProductOrdersController < ApplicationController
  load_resource
  before_filter :initialize_countries

  def new
    @product_order = ProductOrder.new(:user_id => current_user.id)
    @product_order.shipping_name = current_user.shipping_name
    @product_order.shipping_last_name = current_user.shipping_last_name
    @product_order.shipping_address = current_user.shipping_address
    @product_order.shipping_town = current_user.shipping_town
    @product_order.shipping_zip = current_user.shipping_zip
    @product_order.shipping_province = current_user.shipping_province
    @product_order.shipping_country = current_user.shipping_country
    @product_order.shipping_phone = current_user.shipping_phone

    @products = Product.visible
    @products.each do |product|
      @product_order.order_products.build(:product_id => product.id, :quantity => 0)
    end
  end

  def create
    if params[:product_order]
      purge_null_products(params[:product_order])
      @product_order = ProductOrder.new(product_order_params)
      @product_order.user = current_user

      if @product_order.save
        redirect_to finalize_product_order_path(@product_order)
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  def finalize
    redirect_to root_path if @product_order.paid
  end

  private

  def purge_null_products(params_order)
    params_order[:order_products_attributes] = params_order[:order_products_attributes].select do |k,v|
      v["quantity"].present? && v["quantity"].to_i > 0
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_order_params
    params.require(:product_order).permit(:user_id, :price,
    {order_products_attributes: [:id, :product_id, :quantity]},
    :shipping_name, :shipping_last_name, :shipping_address,
    :shipping_town, :shipping_zip, :shipping_province,
    :shipping_country, :shipping_phone, :bonus_points,
    :paid, :ref)
  end

  def initialize_countries
    @shipping_countries = Carmen::Country.all.select{|c| ProductOrder::SHIPPING_COUNTRIES.include?(c.code)}
  end
end
