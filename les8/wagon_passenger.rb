class WagonPassenger < Wagon
  attr_reader :type
  
  def initialize(number, company, total_space)
    super(number, company, total_space)
    @type = "пассажирский"
  end

  def take_space
    raise RuntimeError, "В вагоне нет свободных мест" if free_space == 0
      self.occupied_space += 1 
      self.free_space -= 1
  end

end