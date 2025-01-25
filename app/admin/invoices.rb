ActiveAdmin.register Invoice do
  permit_params :order_id, :total_amount, :invoice_status, :stripe_invoice_id, :currency, :description, :user_id

  index do
    column :id
    column :user
    column :stripe_invoice_id
    column :amount_due
    column :currency
    column :invoice_status
    column :created_at
  end
end
