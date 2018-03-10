class Training < ApplicationRecord
  belongs_to  :program,
              optional: true

  validates :name,
            :description,
            :queue,
            presence: true
end
