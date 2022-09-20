class TrainCargo < Train
  attr_reader :type

  def initialize(id, company)
    super
    @type = "грузовой"
  end

end