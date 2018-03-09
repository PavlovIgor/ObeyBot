class UserSaveAdapter
  def self.adapt(data)
    {
      from_key: data['id'],
      is_bot: data['is_bot'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      username: data['username'],
      lang_code: data['language_code']
    }
  end
end
