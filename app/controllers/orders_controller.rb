class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new 
  end

  def create
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        puts @order.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost, order_items_attributes: [:dish_id, :quantity, :total_price, :_destroy])
  end
end
