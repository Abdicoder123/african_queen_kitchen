ActiveAdmin.register Invoice do
  permit_params :order_id, :total_amount, :invoice_status, :stripe_invoice_id, :currency, :description, :user_id

  index do
    panel "Invoices Overview" do
      div do
        h3 "Here is where all of the invoices for orders are stored."
        h3 "Once you can confirm an order, an invoice is automatically created and will appear here."
        h3 "The 'Order' column is a link to check the details of the order associatied with the invoice."
        h3 "This is the place you can refer to check if an order has been paid for."
        h3 "During 'Draft' the invoice will not yet amount to anything."
        h3 "If you cancel an order, the status will be 'Deleted'."
        h3 "Once you accept and confirm an order, the amount due will show up."
      end
    end

    column :id
    column :user
    column :stripe_invoice_id
    column :order do |invoice|
      order = invoice.order
    end
    column :amount_due do |invoice|
      total = invoice.total_amount
      number_to_currency(total)
    end
    column :currency
    column :invoice_status
    column :created_at
    actions
  end

  actions :index, :show

  show do |invoice|
    panel "Invoices Overview" do
      div do
        h3 "Here is another view of the invoice."
        h3 "You can view the details of the order by clicking the link in the 'Order' row."
      end
    end

    attributes_table do
      row :id
      row :user
      row :email do |record|
        record.user&.email
      end
      row :stripe_invoice_id
      row :invoice_status
      row :created_at
      row :amount_due do |invoice|
        total = invoice.total_amount
        number_to_currency(total)
      end
      row :order do |invoice|
        order = invoice.order
      end
    end
  end
end
