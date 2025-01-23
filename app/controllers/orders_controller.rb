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
  end

  def create
    @order = current_user.orders.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to edit_order_path(@order), notice: "Order was successfully created." }
        format.json { render :edit, status: :created, location: @order }
      else
        # Log error messages for debugging
        flash.now[:alert] = @order.errors.full_messages.join(", ")
        format.html { render :new, status: :unprocessable_entity, notice: "Fill the form completey" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit
    @order = Order.find(params[:id])
    @order_dishes = @order.order_dishes
  end

  def update
    @order = Order.find(params[:id])
    
    respond_to do |format|
      if @order.update(order_params)
        @order.update(status: "Pending")

        # Call the CreateInvoiceService
        service = CreateInvoiceService.new(@order.id) 
        result = service.create_invoice

        if result[:success]
          flash[:notice] = "Order updated and invoice created successfully! Invoice ID: #{result[:invoice_id]}"
        else
          flash[:alert] = "Order updated, but invoice creation failed: #{result[:error]}"
        end

        format.html { redirect_to @order, notice: "Order was submitted." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy!
      respond_to do |format|
        format.html { redirect_to orders_path, status: :see_other, notice: "Order was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end



  private

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost)
  end
end
