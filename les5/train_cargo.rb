class TrainCargo < Train

  attr_reader :type

  def initialize(id)
    super
    @type = "cargo"
  end

  #прицепить грузовой вагон, если поезд стоит
  def add_wagon(wagon)
    if @wagon.type == "cargo" && @speed == 0
      wagon << @wagons
    end

  end

end