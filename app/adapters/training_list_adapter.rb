class TrainingListAdapter
  def self.adapt(training_list)
    {
      keyboard: [
        training_list.pluck(:name).collect { |x| [x] }
      ],
      resize_keyboard: true,
    }
  end
end
