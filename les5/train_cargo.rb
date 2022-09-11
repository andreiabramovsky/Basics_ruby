class TrainCargo < Train
  attr_reader :type

  def initialize(id)
    super
    @type = "грузовой"
  end

end