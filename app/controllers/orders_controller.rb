class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.order(created_at: :desc)

  end
  
  def show
    @order = Order.find(params[:id])
    @order_dishes = @order.order_dishes
    @dishes = @order.dishes
  end

  def new
    @order = Order.new 
    @order.order_dishes.build 
  end

  def create
    @order = current_user.orders.new(order_params)
  
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        # Log error messages for debugging
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  private

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost, order_dishes_attributes: [:dish_id, :quantity, :total_price, :_destroy])
  end
end
