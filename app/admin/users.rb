ActiveAdmin.register User do
  permit_params :username, :first_name, :last_name, :program_id

  index do
    selectable_column
    id_column
    column :username
    column :first_name
    column :last_name
    actions
  end

end
