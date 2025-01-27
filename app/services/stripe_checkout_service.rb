class StripeCheckoutService
    def initialize(invoice, user)
      @user = user
      @invoice = invoice
    end

    def create_checkout_session
        session = Stripe::Checkout::Session.create({
        payment_method_types: [ "card" ],
        customer: @user.stripe_customer_id,
        invoice: @invoice
        line_items: [
          {
            price_data: {
              currency: "usd",
              product_data: {
                name: "Invoice ##{@invoice.stripe_invoice_id}",
                description: "Payment for (#{@invoice.description})"
              },
              unit_amount: (@invoice.total_amount * 100).to_i # Convert to cents
            },
            quantity: 1
          }
        ],
        mode: "payment",
        success_url: "http://localhost:3000",
        cancel_url: "http://localhost:3000"
      })

        @invoice.update!(stripe_checkout_session_id: session.id) # Store the session ID for tracking
        session
    end
end
