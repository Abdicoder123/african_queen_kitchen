ActiveAdmin.register Invoice do
  permit_params :order_id, :total_amount, :invoice_status, :stripe_invoice_id, :currency, :description, :user_id

  index do
    panel "Invoices Overview" do
      div do
        h3 "Here is where all of the invoices for orders are stored."
        h3 "Once you can confirm an order, an invoice is automatically created and will appear here."
        h3 "This is the place you can refer to check if an order has been paid for."
        h3 "During 'Draft' the invoice will not yet amount to anything."
        h3 "If you cancel an order, the status will be 'Deleted'."
        h3 "Once you accept and confirm an order, the amount due will show up."
      end
    end

    column :id
    column :user
    column :stripe_invoice_id
    column :amount_due do |invoice|
      total = invoice.total_amount
      number_to_currency(total)
    end
    column :currency
    column :invoice_status
    column :created_at
  end
end
