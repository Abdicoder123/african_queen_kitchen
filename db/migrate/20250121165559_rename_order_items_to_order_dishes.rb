class RenameOrderItemsToOrderDishes < ActiveRecord::Migration[7.2]
  def change
    rename_table :order_items, :order_dishes
  end
end
