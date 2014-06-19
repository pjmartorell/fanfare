class Admin::ProductsController < Admin::AdminController

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
    if @product.update_attributes(params[:product])
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

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
