require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(
      user_id: 1,
      is_bot: false,
      first_name: 'Igor',
      last_name: 'Pavlov',
      username: 'username',
      lang_code: 'ru',
      age: 100,
      gender: 'm'
    )
  end
  subject { @user }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'user_id not present' do
    before {@user.user_id = "" }
    it { should_not be_valid }
  end


end
