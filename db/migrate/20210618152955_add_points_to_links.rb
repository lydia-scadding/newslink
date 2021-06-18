class AddPointsToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :points, :integer, default: 0
  end
end
