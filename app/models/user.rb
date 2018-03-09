class User < ApplicationRecord
  belongs_to :program, optional: true

  validates :user_id, presence: true
  validates :age, numericality: true

end
