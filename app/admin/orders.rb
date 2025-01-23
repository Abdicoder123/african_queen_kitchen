ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :delivery_date, :status, :event_details, :group_size, :total_cost
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :delivery_date, :status, :event_details, :group_size, :total_cost]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
