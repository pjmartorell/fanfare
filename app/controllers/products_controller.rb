# encoding: utf-8
class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.visible
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.visible.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :bonus_points, :product_index_image,
    :product_show_image, :description, :visible)
    end
end