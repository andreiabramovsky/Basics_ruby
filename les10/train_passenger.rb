# TrainPassanger

# class TrainPassenger
class TrainPassenger < Train
  def initialize(id, company, type)
    super(id, company, type)
    @type = 'пассажирский'
  end
end
