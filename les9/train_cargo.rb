# TrainCargo

# class TrainCargo
class TrainCargo < Train
  attr_reader :type

  def initialize(id, company, type)
    super(id, company, type)
    @type = 'грузовой'
  end
end
