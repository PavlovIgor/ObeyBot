ActiveAdmin.register Completed do
  permit_params :user, :training

  index do
    selectable_column
    id_column
    column :user
    column :training
    actions
  end

end
