class AddBonusPointsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :bonus_points, :integer
  end
end
