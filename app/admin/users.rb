ActiveAdmin.register User do

  index do
    selectable_column
    id_column
    column :username
    column :first_name
    column :last_name
    actions
  end

end
