class User < ApplicationRecord
  belongs_to  :program,
              optional: true

  validates :from_key,
            presence: true
  validates :age,
            numericality: true,
            allow_blank: true

end
