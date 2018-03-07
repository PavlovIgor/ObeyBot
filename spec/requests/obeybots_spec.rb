require 'telegram/bot/rspec/integration'

RSpec.describe TelegramWebhookController, :telegram_bot do

  feature '#start' do

    subject { -> { dispatch_command :start } }

    let(:first_name) { "Igor" }
    let(:last_name) { "Pavlov" }
    let(:username) { "username" }
    let(:welcome_text) { "\r\nРаскажи немного о себе. Сколько тебе лет?" }
    let(:test_data) {{
          id: from_id,
          username: username,
          first_name: first_name,
          last_name: last_name
      }}

    describe 'User with first_name and last_name' do
      let(:from){ test_data }
      it { should respond_with_message 'Привет Igor Pavlov!'+welcome_text }
    end

    describe 'User without first_name' do
      before { test_data['first_name'] = '' }
      let(:from){ test_data }
      it { should respond_with_message 'Привет username!'+welcome_text }
    end

    describe 'User without last_name' do
      before { test_data['last_name'] = '' }
      let(:from){ test_data }
      it { should respond_with_message 'Привет username!'+welcome_text }
    end

    describe 'User without last_name' do
      before do
        test_data['username'] = ''
        test_data['first_name'] = ''
        test_data['last_name'] = ''
      end
      let(:from){ test_data }
      it { should respond_with_message 'Привет stranger!'+welcome_text }
    end

  end

end
