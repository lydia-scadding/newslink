class RemovePointsFromLinks < ActiveRecord::Migration[6.0]
  def change
    remove_column :links, :points, :integer
  end
end
