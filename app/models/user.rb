class User < ApplicationRecord
  validates :user_id, presence: true

  def create_from_data(data)
    self.create(
      user_id: data['id'],
      is_bot: data['is_bot'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      username: data['username'],
      lang_code: data['language_code'],

    )
  end
end