class Completed < ApplicationRecord
  self.table_name = 'completed'

  belongs_to :user
  belongs_to :training
end
