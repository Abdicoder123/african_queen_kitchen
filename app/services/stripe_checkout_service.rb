class StripeCheckoutService
    def initialize(invoice)
      @invoice = invoice
    end

    def create_checkout_session
        session = Stripe::Checkout::Session.create({
        payment_method_types: [ "card" ], # You can add other payment methods like Apple Pay, Google Pay
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
        success_url: "http://localhost:3000/orders",
        cancel_url: "http://localhost:3000/orders"
      })

        @invoice.update!(stripe_checkout_session_id: session.id) # Store the session ID for tracking
        session
    end
end
