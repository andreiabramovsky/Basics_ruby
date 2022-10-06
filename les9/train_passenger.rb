# TrainPassanger

# class TrainPassenger
class TrainPassenger < Train
  attr_reader :type

  def initialize(id, company, type)
    super(id, company, type)
    @type = 'пассажирский'
  end
end
