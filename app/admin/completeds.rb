ActiveAdmin.register Completeds do
  permit_params :user, :training

  index do
    selectable_column
    id_column
    column :name
    column :training
    actions
  end

end
