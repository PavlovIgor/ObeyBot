require 'telegram/bot/rspec/integration'

RSpec.describe TelegramWebhookController, :telegram_bot do
  def reply
    bot.requests[:sendMessage].last
  end

  before { @program = FactoryGirl.create(:program) }
  before do
    (1..3).each_with_index do |i|
      FactoryGirl.create(:training, name: 'Тренировка №'+i.to_s, queue: i, program: @program)
    end
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
    let(:welcome_text) { "\r\nРаскажите немного о себе." }
    let(:age_question) { "Сколько Вам лет?" }

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
    let(:age_question) { "Сколько Вам лет?" }

    describe "user send number his age after start" do
      subject { -> { dispatch_message '100' } }
      before { dispatch_command :start }
      it { should respond_with_message success_text }
      it 'responce' do
        should respond_with_message gender_text
        expect(reply[:reply_markup]).to be_present
        expect(reply[:reply_markup][:keyboard]).to match_array([["мужской", "женский"]])
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
      it { should respond_with_message age_question }
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
      it { expect(reply[:reply_markup][:keyboard]).to match_array([["мужской","женский"]]) }
    end

  end

  feature '#skill_level' do

    let(:from){ test_data }
    let(:success_text){ "Отлично!" }
    let(:program_with_list){ "\r\nПрограмма для начинающих" }
    let(:error_text){ 'Неверный формат. Повторите попытку.' }

    describe "user send success skill level" do
      subject { -> { dispatch_message 'Программа для начинающих' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      it { should respond_with_message success_text }
      it '' do
        should respond_with_message program_with_list
        expect(reply[:reply_markup]).to be_present
        expect(reply[:reply_markup][:keyboard]).to match_array([["Тренировка №1"], ["Тренировка №2"], ["Тренировка №3"]])
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

  feature "#program" do
    let(:from){ test_data }
    let(:show_program_text){ "\r\nПрограмма для начинающих" }

    describe "show_program" do
      subject { -> { dispatch_message '/show_program' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }
      it { should respond_with_message show_program_text }
      it '' do
        expect(reply[:reply_markup]).to be_present
        expect(reply[:reply_markup][:keyboard]).to match_array([["Тренировка №1"], ["Тренировка №2"], ["Тренировка №3"]])
      end
    end

  end

  feature "#training" do
    let(:from){ test_data }
    let(:show_training_text){ "Тренировка №1\r\n\r\nОписание\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." }
    let(:show_program_text){ "\r\nПрограмма для начинающих" }
    let(:done_program_text){ "Отлично!" }
    let(:return_text){ "Можете вернуться к списку тренировок" }

    describe "show training" do
      subject { -> { dispatch_message 'Тренировка №1' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }
      it '' do
        should respond_with_message show_training_text
      end
      it '' do
        expect(reply[:reply_markup]).to be_present
        # expect(reply[:reply_markup][:keyboard]).to match_array([["Выполнил"], ["Назад"]])
      end
    end

    describe "back from training" do
      subject { -> { dispatch_message 'Назад' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }
      before { dispatch_message 'Тренировка №1' }
      it '' do
        should respond_with_message show_program_text
      end
      it '' do
        expect(reply[:reply_markup]).to be_present
        # expect(reply[:reply_markup][:keyboard]).to match_array([["Тренировка №1"], ["Тренировка №2"], ["Тренировка №3"]])
      end
    end

    describe "done training" do
      subject { -> { dispatch_message 'Выполнил' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }
      before { dispatch_message 'Тренировка №1' }
      it '' do
        should respond_with_message done_program_text
      end
      it '' do
        should respond_with_message return_text
        expect(reply[:reply_markup]).to be_present
        expect(reply[:reply_markup][:keyboard]).to match_array([["Назад"]])
      end
    end

  end

  feature "#menu" do
    describe "menu command" do
      let(:menu_text) { "Меню" }

      subject { -> { dispatch_message '/menu' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }

      it { should respond_with_message menu_text }
      # it { expect(reply[:reply_markup][:keyboard]).to match_array([["Настройки"], ["Программа"]]) }
    end
  end

  feature "#settings" do
    describe "settings command" do
      let(:age_question) { "Сколько Вам лет?" }

      subject { -> { dispatch_message '/settings' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }

      it { should respond_with_message age_question }
    end
  end

  feature "#program" do
    describe "program command" do
      let(:show_program_text){ "\r\nПрограмма для начинающих" }

      subject { -> { dispatch_message '/program' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      before { dispatch_message 'Программа для начинающих' }

      it { should respond_with_message show_program_text }
    end
  end

  feature '#before_action' do
    let(:menu) { "Меню" }

    describe "age" do
      subject { -> { dispatch_message '/menu' } }
      before { dispatch_command :start }
      let(:age_question) { "Сколько Вам лет?" }

      it { should respond_with_message age_question }
      it { should_not respond_with_message menu }
    end

    describe "gender" do
      subject { -> { dispatch_message '/menu' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      let(:gender_question){ "Теперь укажите Ваш пол." }

      it { should respond_with_message gender_question }
      it { expect(reply[:reply_markup][:keyboard]).to match_array([["мужской","женский"]]) }
      it { should_not respond_with_message menu }
    end

    describe "program" do
      subject { -> { dispatch_message '/menu' } }
      before { dispatch_command :start }
      before { dispatch_message '100' }
      before { dispatch_message 'мужской' }
      let(:skills_question){ "Теперь выберем Ваш уровень." }

      it { should respond_with_message skills_question }
      it { expect(reply[:reply_markup][:keyboard]).to match_array([["Программа для начинающих"]]) }
      it { should_not respond_with_message menu }
    end

  end


end
