require 'rails_helper'

feature 'Home Page' do
  feature 'index' do
    before { visit root_path }
    subject { page }

    it { should have_link('ObeyFit') }
    it { should have_link('ObeyBot') }
  end
end
