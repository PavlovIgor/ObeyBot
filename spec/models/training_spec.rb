require 'rails_helper'

RSpec.describe Training, type: :model do
  before { @training = FactoryGirl.build(:training) }
  subject { @training }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'name not present' do
    before {@training.name = "" }
    it { should_not be_valid }
  end

  describe 'desc not present' do
    before {@training.description = "" }
    it { should_not be_valid }
  end

  describe 'queue not present' do
    before {@training.queue = nil }
    it { should_not be_valid }
  end

end
