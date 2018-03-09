class TrainingListAdapter
  def self.adapt(training_list)
    {
      keyboard: [
        training_list.pluck(:name)
      ],
      resize_keyboard: true,
    }
  end
end
