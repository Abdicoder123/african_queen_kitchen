class CreateInvoiceService
  def initialize(order_id)
    @order = Order.find(order_id)
    @order_dishes = @order.order_dishes
  end

  def create_invoice
    user = @order.user # Grabs the user
    stripe_customer_id = user.stripe_customer_id # Grabs the stripe_customer_id from database

    # Create the actual invoice
    stripe_invoice = Stripe::Invoice.create({
      customer: stripe_customer_id,
      description: "Invoice for Orders: #{@order_dishes.map { |dish| dish.dish.title }.join(', ')}",
      auto_advance: false,
      collection_method: "send_invoice",
      days_until_due: 30
    })

    if stripe_invoice
      create_invoice_items(stripe_invoice)
      save_invoice(user, stripe_invoice)
    end


  end


  def create_invoice_items(stripe_invoice)
    # Create InvoiceItems for each dish in the order
    @order_dishes.each do |order_dish_item|
      unitPrice = order_dish_item.dish.price # Stripe operates in cents. $1 = 100 cents
      unitPrice *= 100
      invoiceId = stripe_invoice.id # Grab the invoice id
      invoiceItem = Stripe::InvoiceItem.create({
        customer: stripe_invoice.customer,
        description: order_dish_item.dish.title, # Name of the dish
        unit_amount: unitPrice, # Price of individual dish in cents
        currency: "usd",
        quantity: order_dish_item.quantity, # Quantity of the dish
        invoice: invoiceId
      })
    end
  end

  def save_invoice(user, stripe_invoice)
    # Save the invoice details to the Invoice model
    invoice = Invoice.create!(
      stripe_invoice_id: stripe_invoice.id,
      user: user,
      order: @order,
      total_amount: stripe_invoice.amount_due,
      currency: stripe_invoice.currency,
      description: stripe_invoice.description,
      invoice_status: stripe_invoice.status # e.g., 'draft' or 'open'
    )
  end
end
