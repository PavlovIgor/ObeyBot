require 'rails_helper'

feature 'Test Home Page' do

  before { visit root_path }
  subject { page }

  it { should have_http_status(200) }
  it { should have_link(Figaro.env.app_name) }

end
