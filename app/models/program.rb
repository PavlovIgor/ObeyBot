class Program < ApplicationRecord
  has_many :trainings, dependent: :nullify
  validates :name, presence: true
end
