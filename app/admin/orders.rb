ActiveAdmin.register Order do
  permit_params :user_id, :delivery_date, :status, :event_details, :group_size, :total_cost

  # Action to update invoice
  member_action :update_invoice, method: :patch do
    order = Order.find(params[:id]) # Fetch the order from params
    invoice = order.invoice # Access the invoice associated with the order

    # Check if the invoice exists in the database
    if invoice
      stripe_invoice_id = invoice.stripe_invoice_id # Fetch the Stripe invoice ID
      service = FetchInvoiceService.new(stripe_invoice_id) # Call service to fetch invoice details
      result = service.fetch_invoice
      totalInDollars = (result.amount_due.to_f) / 100

      if result
        # Send the invoice email to the user associated with this invoice
        # Finalize the invoice so it gets sent out
        Stripe::Invoice.finalize_invoice(stripe_invoice_id)

        # Update the invoice and order with the fetched data
        invoice.update(invoice_status: "Payment Pending", total_amount: totalInDollars)
        order.update(status: "Confirmed", total_cost: totalInDollars)

        flash[:notice] = "Invoice and order are now official!"
      else
        flash[:alert] = "Failed to fetch invoice details."
      end
    else
      flash[:alert] = "Invoice not found for this order."
    end

    redirect_to admin_order_path(order) # Redirect to the order's show page
  end


  index do
    panel "Order Overview" do
      div do
        h3 "Manage and accept your orders here!"
        h3 "Click 'View' to see the details of an order and click 'Edit' to manually
        edit the status of the order."
        h3 "Click 'Accept Order' when you are ready to accept an order."
      end
    end

    selectable_column
    column :user
    column :delivery_date
    column :status
    column :group_size
    column :total_price_of_order do |order|
      total_order_price = order.order_dishes.sum do |order_dish|
        order_dish.quantity * order_dish.dish.price
      end
      number_to_currency(total_order_price)
    end
    column :created_at
    actions # to show the view and edit actions
    # Define the Actions column
    column "Actions" do |order|
      # Check if the order is still Pending
      if order.status == "Pending" && order.invoice.present? # Ensure the order has an invoice
        # Add a button to accept the order and update the invoice
        link_to "Accept Order", update_invoice_admin_order_path(order), method: :patch
      end
    end
  end


  actions :all, except: [ :new, :create, :destroy ]

  show do
    panel "Order Actions" do
      div do
        h3 "In the upper right corner of this page, there is an 'Edit Order' button. Upon clicking it, you
        can manually change the status of an order."
      end
    end
    attributes_table do
      row :id
      row :user
      row :email do |record|
        record.user&.email
      end
      row :total_price do
        total_order_price = order.order_dishes.sum do |order_dish|
          order_dish.quantity * order_dish.dish.price
        end
        number_to_currency(total_order_price)
      end
      row :status
      row :event_details
      row :delivery_date
      row :created_at
      row :updated_at
    end

    panel "Dishes in this Order" do
      if order.dishes.any?
        table_for order.dishes do
          column :id
          column :title
          column :quantity do |dish|
            order.order_dishes.find_by(dish_id: dish.id)&.quantity || "N/A"
          end
          column :price
          column :total_price_of_dishes do |dish|
            order_dish = order.order_dishes.find_by(dish_id: dish.id)
            if order_dish
              total = order_dish.quantity * dish.price
              number_to_currency(total)
            else
              "N/A"
            end
          end
        end
      else
        div do
          "No dishes have been added to this order."
        end
      end
    end
  end

  form do |f|
    panel "Order Details" do
      attributes_table_for f.object do
        row :id
        row :user
        row :email do |record|
          record.user&.email
        end
        row :total_price
        row :status
        row :created_at
        row :updated_at
      end
    end
    panel "Order Status Note" do
      div do
        h3 "Manually changing the status of an order is helpful when cancelling the order but be mindful for other statuses."
        h3 "Reminder for each status:"
        h3 "Order Creation - means the customer has yet to finalized their order and should not be touched yet."
        h3 "Pending - means the customer has submitted their order and is waiting to hear back from you."
        h3 "Confirmed - means you have confirmed the order for the customer."
        h3 "Completed - means that the customer has successfully paid for their order."
        h3 "Cancelled - means that you have politely declined the customer's order."
        h3 "Note: it may say 'pending' in the changeable form below as default, but if you don't want to change the status simply click 'cancel'."
      end
    end
    f.inputs "Update Order Status" do
      f.input :status, as: :select, collection: %w[pending confirmed shipped completed canceled], include_blank: false
    end
    f.actions
  end
end
