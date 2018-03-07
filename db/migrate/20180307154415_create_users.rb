class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.boolean :is_bot
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :lang_code
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
