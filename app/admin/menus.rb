ActiveAdmin.register Menu do
  permit_params :title, :description, :category, :active, :special_notes, images: []

  index do
    panel "Menu Overview" do
      div do
        h3 "This is where all of your active menus are!"
        h3 "Each of your dishes belong to a menu."
        h3 "You can view, edit and delete your menus as you see fit by clicking the respective links."
        h3 "Upon clicking edit, you can toggle whether or not a menu is active as well as add a description."
        h3 "In the upper right corner, you can click 'New Menu' to create a new menu you want to add."
      end
    end

    selectable_column
    id_column
    column :title
    column :active
    column :created_at
    column :updated_at
    column "Images" do |menu|
      if menu.images.attached?
        menu.images.map do |image|
          image_tag image, size: "50x50" # Thumbnail preview
        end.join(" ").html_safe
      else
        "No images uploaded"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Menu Details" do
      f.input :title
      f.input :description
      f.input :category
      f.input :active
      f.input :special_notes
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  filter :title
  filter :description
  filter :category
  filter :active
  filter :created_at

  # Prevent ActiveAdmin from creating default filters for images
  controller do
    def scoped_collection
      super.includes(:images_attachments) # Optimize queries for image display
    end
  end
end
