class WagonPassenger < Wagon
  attr_reader :type, :number, :total_seats, :occupied_seats, :free_seats
  attr_writer :occupied_seats, :free_seats

  def initialize(number, company, total_seats)
    super(number, company)
    @type = "пассажирский"
    @total_seats = total_seats
    @free_seats = total_seats
    @occupied_seats = 0
  end

  #total_seats = free_seats + occupied_seats

  def take_seat
    raise RuntimeError, "В вагоне нет свободных мест" if free_seats == 0
    #if free_seats_is_available
      self.occupied_seats += 1 
      self.free_seats -= 1 
    #end
  end

  def get_occupied_seats
    occupied_seats
  end

  def get_free_seats
    free_seats
  end

end