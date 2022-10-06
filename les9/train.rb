# Train

# class Train
class Train
  include Company
  include InstanceCounter
  attr_reader :id, :speed, :route, :wagons, :current_station, :previous_station, :next_station, :company, :type

  @trains = []
  ID_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze

  def initialize(id, company, type)
    @id = id
    @company = company
    @type = type
    @speed = 0
    @wagons = []
    @route = nil
    @@trains << self
    register_instance
    validate!
  end

  def wagons_of_train(&block)
    wagons.each { |wagon| block.call(wagon) }
  end

  def amount_of_wagons
    wagons.size
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.find(id)
    @@trains.find { |train| train.id == id }
  end

  # может набирать скорость
  def speed_up(speed)
    @speed = speed
  end

  # может возвращать текущую скорость
  def current_speed
    speed
  end

  # может тормозить
  def speed_down
    @speed = 0
  end

  # прицепить вагон
  def add_wagon(wagon)
    wagons << wagon if wagon.type == type && speed.zero?
  end

  # отцепить вагон
  def delete_wagon(wagon)
    wagons.delete(wagon) if wagon.type == type && speed.zero?
  end

  # может принимать маршрут
  def take_route(route)
    @route = route
    @current_station = route.first_station
    @previous_station = 'Вы на первой станции маршрута'
    @next_station = route.stations[1]
  end

  # может перемещаться по маршруту вперед
  def forward
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.last_station
      puts 'Вы прибыли на конечную станцию'
    else
      @previous_station = current_station
      @current_station = new_station_forward_from(previous_station)
      @next_station = new_station_forward_from(current_station)
    end
  end

  # может перемещаться по маршруту назад
  def back
    if route.nil?
      puts 'Выберите маршрут'
    elsif current_station == route.first_station
      puts 'Вы на начальной станции маршрута'
    else
      @previous_station = current_station
      @current_station = new_station_back_from(previous_station)
      @next_station = new_station_back_from(current_station)
    end
  end

  # может возвращать предыдущую, текущую, следующую станции по маршруту
  def location
    puts "Current station - #{current_station.name}"
    puts "previousvious station - #{previous_station.name}"
    puts "Next station - #{next_station.name}"
  end

  protected

  # возвращает индекс станции на маршруте поезда
  def find_index_of_station(station)
    route.stations.index(station)
  end

  def new_station_forward_from(station)
    route.stations[find_index_of_station(station) + 1]
  end

  def new_station_back_from(station)
    route.stations[find_index_of_station(station) - 1]
  end

  def validate!
    raise 'Не указан номер поезда' if id == ''
    raise 'Не указано название компании изготовителя поезда' if company == ''
    raise 'Неверный формат номера поезда' if id !~ ID_FORMAT
    raise 'Вы не указали тип поезда. Введите: пассажирский или грузовой' if type == ''
    raise 'Неверный тип поезда. Введите: пассажирский или грузовой' unless %w[пассажирский
                                                                              грузовой].include?(@type)
  end
end
