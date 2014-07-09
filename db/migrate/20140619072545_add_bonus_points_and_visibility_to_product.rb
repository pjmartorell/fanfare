class AddBonusPointsAndVisibilityToProduct < ActiveRecord::Migration
  def change
    add_column :products, :bonus_points, :integer, default: 0
    add_column :products, :visible, :boolean, default: false
  end
end
