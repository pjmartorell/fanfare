class Admin::UsersController < Admin::AdminController

  def index
    @users = if params[:search]
      User.where(User.arel_table[:username].matches("%#{params[:search]}%")).paginate(:page => params[:page], :per_page => 100)
    end
  end

  def show
    @promotions = @user.pending_promotions
    @won_prizes = @user.prizes
    @all_prizes = Prize.all
    # @points_movements = @user.points_movements.reorder("id DESC").paginate(:page => params[:page], :per_page => 20)
    # @valid_movements = validate_points_movements(@points_movements)
  end

  def update
    params[:user].each do |key, value|
      @user.send("#{key}=", value)
    end
    @user.skip_reconfirmation!

    @user.save
    redirect_to admin_user_path(@user)
  end
end
