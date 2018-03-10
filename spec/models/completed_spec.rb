require 'rails_helper'

RSpec.describe Completed, type: :model do
  before { @completed = Completed.create(user: FactoryGirl.build(:user), training: FactoryGirl.build(:training)) }
  subject { @completed }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'user not present' do
    before {@completed.user = nil }
    it { should_not be_valid }
  end

  describe 'training not present' do
    before {@completed.training = nil }
    it { should_not be_valid }
  end

end
