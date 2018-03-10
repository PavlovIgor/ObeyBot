class CreateCompleteds < ActiveRecord::Migration[5.1]
  def change
    create_table :completeds do |t|
      t.references :user, foreign_key: true
      t.references :training, foreign_key: true

      t.timestamps
    end
  end
end
