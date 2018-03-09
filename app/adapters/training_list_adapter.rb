class TrainingListAdapter
  def self.adapt(training_list)
    training_list.pluck(:name).join("\r\n")
  end
end
