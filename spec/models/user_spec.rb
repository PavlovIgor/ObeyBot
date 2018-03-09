require 'rails_helper'

RSpec.describe User, type: :model do

  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'user_id not present' do
    before {@user.user_id = "" }
    it { should_not be_valid }
  end

  describe 'user_id not present' do
    before {@user.age = "abc" }
    it { should_not be_valid }
  end


end
