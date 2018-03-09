class TrainingButtonAdapter
  def self.adapt(training)
    {
      keyboard: [
        ['Выполнил'],
        ['Назад'],
      ],
      resize_keyboard: true,
    }
  end
end
