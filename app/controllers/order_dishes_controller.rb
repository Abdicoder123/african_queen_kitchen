class OrderDishesController < ApplicationController
    
    def new
        @order_dish = Order_dish.new
    end
    
    def create
        @order = Order.find(params[:order_id])
        @order_dish = @order.order_dishes.create(order_dish_params)

        if @order_dish.save
          redirect_to edit_order_path(@order), notice: "Dish was added successfully."
        else
          redirect_to edit_order_path(@order), notice: "Make sure you fill in the form completely!"
        end
    end

    private
    # Only allow a list of trusted parameters through.
    def order_dish_params
      params.require(:order_dish).permit(:dish_id, :quantity)
    end
end
