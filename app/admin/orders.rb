ActiveAdmin.register Order do
  permit_params :user_id, :delivery_date, :status, :event_details, :group_size, :total_cost

  index do

    panel "Order Overview" do
      div do
        h3 "Manage and accept your orders"
      end
    end

    selectable_column
    id_column
    column :user
    column :delivery_date
    column :status
    column :group_size
    column :total_price
    column :created_at
    column :updated_at

    # Define the Actions column
    column "Actions" do |order|
      # Check if the invoice status is 'Pending' and the order is not yet accepted
      if order.status == 'Pending'
        # Add a button to accept the order
        link_to "Accept Order"
      end
    end
  end

  actions :all, except: [ :new, :create, :destroy ]

  show do
    attributes_table do
      row :id
      row :user
      row :total_price
      row :status
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Update Order Status" do
      f.input :status, as: :select, collection: %w[pending confirmed shipped completed canceled], include_blank: false
    end
    f.actions
  end
end
