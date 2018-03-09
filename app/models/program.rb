class Program < ApplicationRecord
  has_many :trainings
  validates :name, presence: true
end
