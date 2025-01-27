ActiveAdmin.register Menu do
  permit_params :title, :description, :category, :active, :special_notes

  index do
    panel "Menu Overview" do
      div do
        h3 "This is where all of your active menus are!" 
        h3 "You can view, edit and delete your menus as you see fit by clicking the respective links."
        h3 "Upon clicking edit, you can toggle whether or not a menu is active as well as add a description."
        h3 "In the upper right corner, you can click 'New Menu' to create new menus you want to add."
        h3 "On the right hand side, there is a filter function you can use to find a specific dish."
      end
    end

    selectable_column
    id_column
    column :title
    column :description
    column :category
    column :active
    column :special_notes
    column :created_at
    column :updated_at
    actions
  end

  show do |menu|
      attributes_table do
        row :title
        row :description
        row :category
        row :active
        row :special_notes
        row :created_at
        row :updated_at
      end

    panel "Dishes on this Menu" do
      if menu.dishes.any?
        ul do
          menu.dishes.each do |dish|
            li dish.title
          end
        end
      else
        para "No dishes available for this menu."
      end
    end
  end
end
