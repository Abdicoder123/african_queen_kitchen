ActiveAdmin.register Review do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :dish_id, :user_id, :rating, :comment
  #
  # or
  #
  # permit_params do
  #   permitted = [:dish_id, :user_id, :rating, :comment]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # Show only admin users can delete reviews
  permit_params :rating, :comment, :user_id

  # The index page where reviews are listed
  index do
    selectable_column
    id_column
    column :user
    column :rating
    column :comment
    actions # Show default actions (View, Edit, Delete)
  end

  # You can customize the form where new reviews are created/edited
  form do |f|
    f.inputs do
      f.input :user
      f.input :rating
      f.input :comment
    end
    f.actions
  end

  # Optional: You can define specific actions you want to show to admins (like allowing delete)
  controller do
    def destroy
      # You can add any extra logic here before deleting the review, if necessary
      super # This calls the default ActiveAdmin destroy action
    end
  end
end
