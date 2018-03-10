class TrainingListAdapter
  def self.adapt(training_list)
    {
      keyboard:         training_list.collect { |x| [x.name] }
    }
  end
end
