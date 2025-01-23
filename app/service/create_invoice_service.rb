class CreateInvoiceService
  def initialize(order_id)
    @order = Order.find(order_id)
    @order_dishes = @order.order_dishes
  end

  def create_invoice
    user = @order.user
    stripe_customer_id = user.stripe_customer_id

    # Create invoice using the order_dishes details
    line_items = @order_dishes.map do |dish|
      {
        price_data: {
          currency: 'usd',
          product_data: {
            name: dish.dish.title,
          },
          unit_amount: dish.price_cents,
        },
        quantity: dish.quantity,
      }
    end

    invoice = Stripe::Invoice.create({
      customer: stripe_customer_id,
      description: "Invoice for Orders: #{@order_dishes.map { |dish| dish.dish.title }.join(', ')}",
      auto_advance: true,
      lines: line_items
    })
    
    invoice
      