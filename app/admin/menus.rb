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



  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :category, :active, :special_notes
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :category, :active, :special_notes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
