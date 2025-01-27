ActiveAdmin.register Dish do
  permit_params :menu_id, :title, :description, :price, :customizable, images: []

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
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
