require 'rails_helper'

RSpec.describe User, type: :model do

  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'from_key not present' do
    before {@user.from_key = "" }
    it { should_not be_valid }
  end

  describe 'age not numeric' do
    before {@user.age = "abc" }
    it { should_not be_valid }
  end


end
