ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    panel "Admin User Accounts Overview" do
      div do
        h3 "This is a record of the admin account of African Queen Kitchen."
        h3 "There is typically one admin account."
        h3 "If you find that you need to create a second admin account, there is a 'New Admin' button in the top right corner"
      end
    end
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
