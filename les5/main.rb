require_relative 'route'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'train_passenger.rb'
require_relative 'train_cargo.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_passenger.rb'

class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start_menu
    puts "Выберите действие и нажмите соответствующую цифру\n
    1 - создать станцию\n
    2 - создать поезд\n
    3 - создать маршрут\n
    4 - добавить станцию в маршрут\n
    5 - удалить станцию из маршрута\n
    6 - назначить маршрут поезду\n
    7 - прицепить вагон к поезду\n
    8 - отцепить вагон от поезда\n
    9 - переместить поезд вперед\n
    10 - переместить поезд назад\n
    11 - показать станции на маршруте\n
    12 - показать список поездов на станции"
  end

  def program
    loop do
      start_menu
      choice = gets.chomp.to_i
      case choice
        when 1
          new_station
        when 2
          new_train
        when 3
          new_route
        when 4
          add_station
        when 5
          delete_station
        when 6
          set_route
        when 7
          add_wagon
        when 8
          delete_wagon
        when 9
          move_forward
        when 10
          move_back
        when 11
          list_stations
        when 12
          list_trains
        else
          break
      end
    end
  end

  #создавать станции
  def new_station
    puts "Введите название станции"
    @stations << Station.new(gets.chomp)
  end

  #создавать поезда
  def new_train
    puts "Введите номер поезда"
    id = gets.chomp
    puts "Введите тип поезда: пассажирский или грузовой"
    type = gets.chomp.downcase
    if type == "пассажирский"
      @trains << TrainPassenger.new(id)
    else
      @trains << TrainCargo.new(id)
    end
  end


  #создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def find_station(station_name)
    return @stations.find { |station| station.station_name == station_name}  
  end

  def find_route(start_station, finish_station)
    return @routes.index(@routes.find {|route| route.stations_list[0].station_name == start_station && route.stations_list[-1].station_name == finish_station})
  end

  def new_route
    puts "Введите начало маршрута"
    start_station = gets.chomp
    puts "Введите конец маршрута"
    finish_station = gets.chomp
    @routes << Route.new(find_station(start_station), find_station(finish_station))
  end

  def add_station
   puts "Введите название станции"
   station_name = gets.chomp
   puts "Введите начало маршрута"
   start_station = gets.chomp
   puts "Введите конец маршрута"
   finish_station = gets.chomp
   @routes[find_route(start_station, finish_station)].add_new_station(find_station(station_name))
  end

  def delete_station
    puts "Введите название станции"
   station_name = gets.chomp
   puts "Введите начало маршрута"
   start_station = gets.chomp
   puts "Введите конец маршрута"
   finish_station = gets.chomp
   @routes[find_route(start_station, finish_station)].delete_station(find_station(station_name))
  end

  #назначать маршрут поезду
  def find_train(id)
    return @trains.index(@trains.find {|train| train.id == id})
  end

  def set_route
    puts "Введите начало маршрута"
    start_station = gets.chomp
    puts "Введите конец маршрута"
    finish_station = gets.chomp
    puts "Введите номер поезда"
    id = gets.chomp
    @trains[find_train(id)].take_route(@routes[find_route(start_station, finish_station)])
    find_station(start_station).take_train(@trains[find_train(id)])
  end
  
  #добавлять вагоны к поезду
  def add_wagon
    puts "Введите номер вагона"
    wagon_id = gets.chomp.to_i
    puts "Введите тип вагона: пассажирский или грузовой"
    wagon_type = gets.chomp
    if wagon_type == "пассажирский"
      wagon = WagonPassenger.new(wagon_id)
    else
      wagon = WagonCargo.new(wagon_id)
    end
    puts "Введите номер поезда, к которому нужно прицепить вагон"
    id = gets.chomp
    @trains[find_train(id)].add_wagon(wagon)
  end

  #отцеплять вагоны от поезда
  def delete_wagon
    puts "Введите номер вагона"
    wagon_id = gets.chomp.to_i
    puts "Введите номер поезда, от которого нужно отцепить вагон"
    id = gets.chomp
    wagon = @trains[find_train(id)].wagons.find{|wagon| wagon.number == wagon_id}
    @trains[find_train(id)].delete_wagon(wagon)
  end

  #перемещать поезд по маршруту вперед и назад
  def move_forward
    puts "Введите номер поезда"
    id = gets.chomp
    puts "Введите начальную станцию"
    start_station = gets.chomp
    puts "Введите конечную станцию"
    finish_station = gets.chomp
    @trains[find_train(id)].forward
    find_station(@trains[find_train(id)].current_station.station_name).take_train(@trains[find_train(id)])
    find_station(@trains[find_train(id)].previous_station.station_name).send_train(@trains[find_train(id)])
  end

  def move_back
    puts "Введите номер поезда"
    id = gets.chomp
    puts "Введите начальную станцию"
    start_station = gets.chomp
    puts "Введите конечную станцию"
    finish_station = gets.chomp
    @trains[find_train(id)].back
    find_station(@trains[find_train(id)].current_station.station_name).take_train(@trains[find_train(id)])
    find_station(@trains[find_train(id)].previous_station.station_name).send_train(@trains[find_train(id)])
  end

  #просматривать список станций и список поездов на станции
  def list_stations
    puts "Введите начало маршрута"
    start_station = gets.chomp
    puts "Введите конец маршрута"
    finish_station = gets.chomp
    @routes[find_route(start_station, finish_station)].show_route
  end

  def list_trains
    puts "Введите название станции"
    station_name = gets.chomp
    find_station(station_name).trains_list
  end

end

Main.new.program