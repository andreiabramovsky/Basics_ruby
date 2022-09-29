class WagonCargo < Wagon
  
  attr_reader :type, :number, :total_volume, :free_volume, :occupied_volume
  attr_writer :free_volume, :occupied_volume

  def initialize(number, company, total_volume)
    super(number, company)
    @type = "грузовой"
    @total_volume = total_volume
    @free_volume = total_volume
    @occupied_volume = 0
  end

  def take_volume(volume)
    raise RuntimeError, "Загружаемый объём больше свободного места в вагоне. Уменьшите ваш объём" if volume > free_volume
    raise RuntimeError, "В вагоне нет свободного места" if free_volume == 0  
    self.occupied_volume += volume
    self.free_volume -= volume
  end

  def get_occupied_volume
    occupied_volume
  end

  def get_free_volume
    free_volume
  end

end