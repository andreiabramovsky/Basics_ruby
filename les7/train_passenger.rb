class TrainPassenger < Train
  attr_reader :type

  def initialize(id, company, type)
    super(id, company, type)
  end

end