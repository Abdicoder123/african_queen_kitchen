class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.order(created_at: :desc)

    @orders.each do |order|
      # If the invoice exists in the database and there is a stripe invoice id
      if order.invoice && order.invoice.stripe_invoice_id && order.status != "Cancelled"
        stripe_invoice_id = order.invoice.stripe_invoice_id
        invoice = order.invoice
        stripe_invoice = Stripe::Invoice.retrieve(stripe_invoice_id)
        puts "XXXXXXXXXXXXXXXXXXXXX#{stripe_invoice.status}"
        if order && stripe_invoice.status == "paid"
          update_payment(invoice, order)
        end
      else

      end
    end
  end


  def show
    @order = Order.find(params[:id])
    @order_dishes = @order.order_dishes
    @dishes = @order.dishes
    @invoice = @order.invoice
  end

  def pay
    @order = Order.find(params[:id])
    @invoice = @order.invoice
    @user = @order.user

    # Redirect to stripe checkout session logic
    if @invoice.invoice_status === "Payment Pending" && @order.status == "Confirmed"
      stripe_invoice = Stripe::Invoice.retrieve(@invoice.stripe_invoice_id)
      redirect_to stripe_invoice.hosted_invoice_url, allow_other_host: true
    end
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
    @menus = Menu.all
    @dishes = Dish.all
  end

  def update
    @order = Order.find(params[:id])
    @order_dishes = @order.order_dishes

    respond_to do |format|
      if @order.update(order_params)
        @order.update(status: "Pending")

        # Call the CreateInvoiceService
        service = CreateInvoiceService.new(@order.id)
        result = service.create_invoice

        if result
          flash[:notice] = "Order was submitted! Waiting for approval.}"
        else
          flash[:alert] = "Order was submitted, but invoice creation failed: #{result[:error]}"
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

  def update_payment(invoice, stripe_invoice)
    # Make sure you find the associated order based on the invoice
    order = invoice.order
    if order
      # Update the invoice, order and create payment status
      invoice.update(invoice_status: "Paid")
      order.update(status: "Completed")
      payment = order.create_payment(payment_status: stripe_invoice.status)
    end
  end

  def fetch_checkout_session
    # Retrieve the existing session
    session = Stripe::Checkout::Session.retrieve(@invoice.stripe_checkout_session_id)

    # Redirect the user to the existing session's URL
    redirect_to session.url, allow_other_host: true
  end

  def order_params
    params.require(:order).permit(:delivery_date, :status, :event_details, :group_size, :total_cost)
  end
end
