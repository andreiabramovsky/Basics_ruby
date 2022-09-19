class TrainPassenger < Train
  attr_reader :type

  def initialize(id)
    super
    @type = "пассажирский"
  end

end