class ChangePriceToDecimalInDishes < ActiveRecord::Migration[7.2]
  def change
    change_column :dishes, :price, :decimal, precision: 8, scale: 2
  end
end
