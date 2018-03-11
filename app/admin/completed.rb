ActiveAdmin.register Completed do
  self.table_name = 'completed'
  permit_params :user, :training

  index do
    selectable_column
    id_column
    column :name
    column :training
    actions
  end

end
