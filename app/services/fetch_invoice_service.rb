class FetchInvoiceService
  def initialize(stripe_invoice_id)
    @stripe_invoice_id = stripe_invoice_id
  end

  def fetch_invoice
      invoice = Stripe::Invoice.retrieve(@stripe_invoice_id)
  end
end
  