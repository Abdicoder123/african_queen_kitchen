ActiveAdmin.register Dish do
  permit_params :menu_id, :title, :description, :image_url, :price, :customizable

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :image_url
    column :price
    column :customizable
    column :created_at
    column :updated_at
    actions
  end
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
