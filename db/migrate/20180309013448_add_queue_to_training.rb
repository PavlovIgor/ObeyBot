class AddQueueToTraining < ActiveRecord::Migration[5.1]
  def change
    add_column :trainings, :queue, :integer
  end
end
