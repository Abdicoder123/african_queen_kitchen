ActiveAdmin.register Menu do
  permit_params :title, :description, :category, :active, :special_notes

  index do
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
end
