require 'rails_helper'

RSpec.describe Program, type: :model do
  before { @program = FactoryGirl.build(:program) }
  subject { @program }

  describe 'all present' do
    it { should be_valid }
  end

  describe 'name not present' do
    before {@program.name = "" }
    it { should_not be_valid }
  end

end
