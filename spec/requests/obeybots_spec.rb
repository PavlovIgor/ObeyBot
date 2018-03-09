require 'telegram/bot/rspec/integration'

RSpec.describe TelegramWebhookController, :telegram_bot do
  def reply
    bot.requests[:sendMessage].last
  end

  let(:first_name) { "Igor" }
  let(:last_name) { "Pavlov" }
  let(:username) { "username" }
  let(:test_data) {{
        id: from_id,
        username: username,
        first_name: first_name,
        last_name: last_name
    }}

  feature '#start' do
    let(:welcome_text) { "\r\nРаскажи немного о себе." }
    let(:age_question) { "Сколько тебе лет?" }

    subject { -> { dispatch_command :start } }

    describe 'User with first_name and last_name' do
      let(:from){ test_data }
      it '' do
        should respond_with_message 'Привет Igor Pavlov!'+welcome_text
        should respond_with_message age_question
      end
    end

    describe 'User without first_name' do
      before { test_data['first_name'] = '' }
      let(:from){ test_data }
      it '' do
        should respond_with_message 'Привет username!'+welcome_text
        should respond_with_message age_question
      end
    end

    describe 'User without last_name' do
      before { test_data['last_name'] = '' }
      let(:from){ test_data }
      it '' do
        should respond_with_message 'Привет username!'+welcome_text
        should respond_with_message age_question
      end
    end

    describe 'User without last_name' do
      before do
        test_data['username'] = ''
        test_data['first_name'] = ''
        test_data['last_name'] = ''
      end
      let(:from){ test_data }
      it '' do
        should respond_with_message 'Привет stranger!'+welcome_text
        should respond_with_message age_question
      end
    end

  end

  feature '#age' do

    let(:from){ test_data }
    let(:success_text){ 'Отлично!' }
    let(:gender_text){ "Теперь укажите Ваш пол." }
    let(:error_text){ 'Неверный формат. Повторите попытку.' }

    describe "user send number his age after start" do
      subject { -> { dispatch_message '100' } }
      before { dispatch_command :start }
      it { should respond_with_message success_text }
      it 'responce' do
        should respond_with_message gender_text
        expect(reply[:reply_markup]).to be_present
      end
    end

    describe "user send string his age after start" do
      subject { -> { dispatch_message 'abc' } }
      before { dispatch_command :start }
      it { should respond_with_message error_text }
    end

    describe "user send nil his age after start" do
      subject { -> { dispatch_message '' } }
      before { dispatch_command :start }
      it { should respond_with_message error_text }
    end

    describe "user send number his age after error" do
      subject { -> { dispatch_message '100' } }
      before { dispatch_command :start }
      before { dispatch_message 'abc' }
      it { should respond_with_message success_text }
      it { should respond_with_message gender_text }
    end

  end

  feature '#gender' do

    let(:from){ test_data }
    let(:success_text){ "Отлично!" }
    let(:skills_question){ "Теперь давай выберем твой уровень." }
    let(:error_text){ 'Неверный формат. Повторите попытку.' }

    describe "user send success gender after age" do
      subject { -> { dispatch_message 'мужской' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      it { should respond_with_message success_text }
    end

    describe "user send error gender after age" do
      subject { -> { dispatch_message 'Не определился' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      it { should respond_with_message error_text }
    end

  end

  feature '#skill_level' do

    let(:from){ test_data }
    let(:success_text){ "Отлично!" }
    before { @program = FactoryGirl.create(:program) }
    before do
      (1..3).each_with_index do |i|
        FactoryGirl.create(:training, name: 'Занятие №'+i.to_s, queue: i, program: @program)
      end
    end
    let(:program_with_list){ "\r\nПрограмма для начинающих" }
    let(:error_text){ 'Неверный формат. Повторите попытку.' }

    describe "user send success skill level" do
      subject { -> { dispatch_message 'новичок' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      it { should respond_with_message success_text }
      it '' do
        should respond_with_message program_with_list
        expect(reply[:reply_markup]).to be_present
      end
    end

    describe "user send error skill level" do
      subject { -> { dispatch_message 'error' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      it { should respond_with_message error_text }
    end

  end

  feature "#menu" do
    let(:from){ test_data }
    let(:show_program_text){ "\r\nПрограмма для начинающих" }

    before { @program = FactoryGirl.create(:program) }
    before do
      (1..3).each_with_index do |i|
        FactoryGirl.create(:training, name: 'Занятие №'+i.to_s, queue: i, program: @program)
      end
    end

    describe "show_program" do
      subject { -> { dispatch_message '/show_program' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'новичок' }
      it { should respond_with_message show_program_text }
      # it '' do
      #   expect(reply[:reply_markup]).to be_present
      # end
    end
  end
end
