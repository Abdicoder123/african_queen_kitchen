ActiveAdmin.register Dish do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :menu_id, :title, :description, :image_url, :price, :customizable
  #
  # or
  #
  # permit_params do
  #   permitted = [:menu_id, :title, :description, :image_url, :price, :customizable]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
