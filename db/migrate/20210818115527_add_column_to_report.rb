class AddColumnToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :post_date, :timestamp
  end
end
