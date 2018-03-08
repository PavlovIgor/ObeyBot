class User < ApplicationRecord
  validates :user_id, presence: true
  validates :age, numericality: true

end
