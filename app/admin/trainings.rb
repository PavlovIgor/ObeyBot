ActiveAdmin.register Training do
  permit_params :name, :description, :queue

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :queue
    actions
  end

end
