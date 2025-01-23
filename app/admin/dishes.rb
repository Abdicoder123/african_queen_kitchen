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
end
