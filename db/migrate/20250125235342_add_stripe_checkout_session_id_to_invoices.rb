class AddStripeCheckoutSessionIdToInvoices < ActiveRecord::Migration[7.2]
  def change
    add_column :invoices, :stripe_checkout_session_id, :string
  end
end
