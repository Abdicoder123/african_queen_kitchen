ActiveAdmin.register Dish do
  permit_params :menu_id, :title, :description, :price, :customizable, images: []

  index do
    panel "Dish Overview" do
      div do
        h3 "This is where all of your dishes are!"
        h3 "You can view, edit and delete every dish as you see fit by clicking the respective links."
        h3 "Upon clicking edit, you can edit any information you need to and update/add a photo."
        h3 "In the upper right corner, you can click 'New Dish' to create new dishes you want to add and even select which menu they belong to."
      end
    end

    selectable_column
    id_column
    column :title
    column :description
    column :price do |dish|
      number_to_currency(dish.price)
    end
    column :customizable
    column :created_at
    column :updated_at
    column "Images" do |dish|
      if dish.images.attached?
        dish.images.map do |image|
          image_tag image, size: "50x50" # Thumbnail preview
        end.join(" ").html_safe
      else
        "No images uploaded"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Dish Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :customizable
      f.input :menu_id, as: :select, collection: Menu.all.pluck(:title, :id)
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  filter :title
  filter :description
  filter :price
  filter :customizable
  filter :created_at

  # Prevent ActiveAdmin from creating default filters for images
  controller do
    def scoped_collection
      super.includes(:images_attachments) # Optimize queries for image display
    end
  end
end
