# TrainCargo

# class TrainCargo
class TrainCargo < Train
  def initialize(id, company, type)
    super(id, company, type)
    @type = 'грузовой'
  end
end
