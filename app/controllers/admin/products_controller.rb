class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:update, :edit, :destroy, :toggle_visible]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = "Product created."
    else
      flash[:error] = "It was not possible to create the product."
    end

    redirect_to admin_products_path
  end

  def update
    if @product.update_attributes(product_params)
      flash[:notice] = "Product updated."
    else
      flash[:error] = "It was not possible to update the product."
    end
    redirect_to admin_products_path
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product removed."
    else
      flash[:error] = "It was not possible to remove the product."
    end

    redirect_to admin_products_path
  end

  def toggle_visible
    @product.toggle!(:visible)
    redirect_to :back
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :bonus_points, :quantity, :product_index_image,
    :product_show_image, :description, :visible)
  end
end
