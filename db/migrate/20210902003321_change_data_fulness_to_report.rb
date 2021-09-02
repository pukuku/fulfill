class ChangeDataFulnessToReport < ActiveRecord::Migration[5.2]
  def change
    change_column :reports, :fulness, :decimal, precision: 5, scale: 3
  end
end
