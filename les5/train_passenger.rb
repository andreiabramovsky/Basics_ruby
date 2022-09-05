class TrainPassenger < Train

  attr_reader :type

  def initialize(id)
    super
    @type = "pass"
  end

  #прицепить пассажирский вагон, если поезд стоит
  def add_wagon(wagon)
    if wagon.type == "pass" && @speed == 0
      @wagons << wagon
    end
  end

  #отцепить
  def delete_wagon(wagon)
    if wagon.type == "pass" && @speed == 0
      @wagons.delete(wagon)
    end
  end

end