class WagonCargo < Wagon
  attr_reader :type

  def initialize(number, company, total_space)
    super(number, company, total_space)
    @type = "грузовой"
  end

  def take_space(volume)
    raise RuntimeError, "Загружаемый объём больше свободного места в вагоне. Уменьшите ваш объём" if volume > free_space
    raise RuntimeError, "В вагоне нет свободного места" if free_space == 0  
    self.occupied_space += volume
    self.free_space -= volume
  end

end