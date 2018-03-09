class RenameUserIdToFromKeyByUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :user_id, :from_key
  end
end
