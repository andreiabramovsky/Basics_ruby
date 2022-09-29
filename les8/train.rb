class Train
  attr_reader :id, :speed, :route, :wagons, :current_station, :previous_station, :next_station, :company
  include Company
  include InstanceCounter
  @@trains = []
  ID_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i

  def initialize(id, company, type) 
      @id = id
      @company = company
      @type = type
      @speed = 0
      @wagons = []
      @route = nil
      @@trains << self
      self.register_instance
      validate!
  end

  def wagons_of_train(&block)
    wagons.each { |wagon| yield(wagon) }
  end

  def amount_of_wagons 
    wagons.size
  end

  def valid?
    validate!
    true
  rescue
    false  
  end

  def self.find(id)
    @@trains.find { |train| train.id == id }
  end

  def speed_up(speed) #может набирать скорость
    @speed = speed
  end
    
  def current_speed #может возвращать текущую скорость
    speed
  end

  def speed_down #может тормозить
    @speed = 0
  end

  def add_wagon(wagon) #прицепить вагон
    wagons << wagon if wagon.type == type && speed == 0
  end

  def delete_wagon(wagon) #отцепить вагон
    wagons.delete(wagon) if wagon.type == type && speed == 0
  end

  def take_route(route) #может принимать маршрут
    @route = route
    @current_station = route.first_station
    @previous_station = "Вы на первой станции маршрута"
    @next_station = route.stations[1]
  end

  def forward #может перемещаться по маршруту вперед
    if route == nil
      puts "Выберите маршрут"
    elsif current_station == route.last_station
      puts "Вы прибыли на конечную станцию"
    else
      @previous_station = current_station
      @current_station = new_station_forward_from(previous_station) #обновить текущую станцию
      @next_station = new_station_forward_from(current_station) #обновить следующую станцию
    end
  end
        
  def back #может перемещаться по маршруту назад
    if route == nil
      puts "Выберите маршрут"
    elsif current_station == route.first_station
      puts "Вы на начальной станции маршрута"
    else
      @previous_station = current_station
      @current_station = new_station_back_from(previous_station)
      @next_station = new_station_back_from(current_station)
    end
  end

  def location #может возвращать предыдущую, текущую, следующую станции по маршруту
    puts "Current station - #{current_station.name}"
    puts "previousvious station - #{previous_station.name}"
    puts "Next station - #{next_station.name}"
  end

  protected

  def find_index_of_station(station) #возвращает индекс станции на маршруте поезда
    route.stations.index(station)
  end

  def new_station_forward_from(station)
    route.stations[find_index_of_station(station) + 1]
  end

  def new_station_back_from(station)
    route.stations[find_index_of_station(station) - 1]
  end

  def validate!
    raise RuntimeError, "Не указан номер поезда" if id == ""
    raise RuntimeError, "Не указано название компании изготовителя поезда" if company == ""
    raise RuntimeError, "Неверный формат номера поезда" if id !~ ID_FORMAT
    raise RuntimeError, "Вы не указали тип поезда. Введите: пассажирский или грузовой" if type == ""
    raise RuntimeError, "Неверный тип поезда. Введите: пассажирский или грузовой" unless ["пассажирский", "грузовой"].include?(@type)
  end

end