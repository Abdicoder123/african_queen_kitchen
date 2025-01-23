class CreateInvoiceService
    def initialize(user, order_dishes_id)
        @user = user
        @order_dishes = Order_dish.where(id: order_item_ids)
    end
  
    def call
      stripe_customer_id = @user.stripe_customer_id
  
      # Build line items for all order items
      line_items = @order_dishes.map do |dish|
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: dish.product_name
            },
            unit_amount: dish.price_cents
          },
          quantity: dish.quantity
        }
      end
  
      # Create the invoice
      invoice = Stripe::Invoice.create({
        customer: stripe_customer_id,
        description: "Invoice for Orders: #{@order_dishes.map(&:id).join(', ')}",
        auto_advance: true,
        lines: line_items
      })
  
      invoice
      