class TrainCargo < Train

  attr_reader :type

  def initialize(id)
    super
    @type = "cargo"
  end

  #прицепить грузовой вагон, если поезд стоит
  def add_wagon(wagon)
    if wagon.type == "cargo" && @speed == 0
      @wagons << wagon
    end
  end

  #отцепить
  def delete_wagon(wagon)
    if wagon.type == "cargo" && @speed == 0
      @wagons.delete(wagon)
    end
  end

end