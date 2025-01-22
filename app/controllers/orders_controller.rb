class OrdersController < ApplicationController
  def index
  end


  private

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost, order_items_attributes: [:dish_id, :quantity, :total_price, :_destroy])
  end
end
