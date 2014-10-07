class AddBonusPointsToOrderProduct < ActiveRecord::Migration
  def change
    add_column :order_products, :bonus_points, :integer
  end
end
