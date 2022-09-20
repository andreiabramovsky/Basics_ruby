class TrainPassenger < Train
  attr_reader :type

  def initialize(id, company)
    super
    @type = "пассажирский"
  end

end