ActiveAdmin.register Dish do
  permit_params :menu_id, :title, :description, :image_url, :price, :customizable

  index do
    panel "Dish Overview" do
      div do
        h3 "This is where all of your dishes are!" 
        h3 "You can view, edit and delete every dish as you see fit by clicking the respective links."
        h3 "Upon clicking edit, you can edit any information you need to."
        h3 "In the upper right corner, you can click 'New Dish' to create new dishes you want to add and even select which menu they belong to."
        h3 "On the right hand side, there is a filter function you can use to find a specific dish."
      end
    end

    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :customizable
    column :created_at
    column :updated_at
    actions
  end

  show do |dish|
    attributes_table do
      row :title
      row :description
      row :price
      row :customizable
      row :created_at
      row :updated_at
    end
  end 
end
