class CreateInvoiceService
  def initialize(order_id)
    @order = Order.find(order_id)
    @order_dishes = @order.order_dishes
  end

  def create_invoice
    user = @order.user #Grabs the user
    stripe_customer_id = user.stripe_customer_id #Grabs the stripe_customer_id from database

     # Create the actual invoice
    invoice = Stripe::Invoice.create({
      customer: stripe_customer_id,
      description: "Invoice for Orders: #{@order_dishes.map { |dish| dish.dish.title }.join(', ')}", 
      auto_advance: false,
      collection_method: 'send_invoice',
      days_until_due: 30,
    })

    # Create InvoiceItems for each dish in the order
    @order_dishes.each do |order_dish_item|
      unitPrice = order_dish_item.dish.price #Stripe operates in cents. $1 = 100 cents
      unitPrice *= 100
      invoiceId = invoice.id #Grab the invoice id 
      invoiceItem = Stripe::InvoiceItem.create({
        customer: stripe_customer_id,
        description: order_dish_item.dish.title, # Name of the dish
        unit_amount: unitPrice, # Price of individual dish in cents
        currency: 'usd',
        quantity: order_dish_item.quantity, # Quantity of the dish
        invoice: invoiceId
      })
    end
  end
end

      