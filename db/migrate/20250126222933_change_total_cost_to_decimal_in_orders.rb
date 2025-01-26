class ChangeTotalCostToDecimalInOrders < ActiveRecord::Migration[7.2]
  def change
    change_column :orders, :total_cost, :decimal, precision: 10, scale: 2
  end
end
