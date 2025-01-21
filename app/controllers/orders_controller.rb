class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end


  private 

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost)
  end
end
