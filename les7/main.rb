require_relative 'company.rb'
require_relative 'instance_counter.rb'
require_relative 'wagon.rb'
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

  MENU = [
    {id: 1, title: "создать станцию", action: :new_station},
    {id: 2, title: "создать поезд", action: :new_train},
    {id: 3, title: "создать маршрут", action: :new_route},
    {id: 4, title: "добавить станцию  в маршрут", action: :add_station},
    {id: 5, title: "удалить станцию из маршрута", action: :delete_station},
    {id: 6, title: "назначить маршрут поезду", action: :set_route},
    {id: 7, title: "прицепить вагон к поезду", action: :add_wagon},
    {id: 8, title: "отцепить вагон от поезда", action: :delete_wagon},
    {id: 9, title: "переместить поезд вперед", action: :move_forward},
    {id: 10, title: "переместить поезд назад", action: :move_back},
    {id: 11, title: "показать станции на маршруте", action: :list_stations},
    {id: 12, title: "показать список поездов на станции", action: :list_trains},
  ]

  def start_menu
    puts "Выберите действие и нажмите соответствующую цифру\n"
    MENU.each do |item|
      puts "#{item[:id]} - #{item[:title]}"
   end
  end

  def program
    loop do
      start_menu
      choice = gets.chomp.to_i
      send(MENU[choice - 1][:action])
    end
  end

  #создавать станции
  def new_station
    name = ask("Введите название станции")
    @stations << Station.new(name)
    puts "Станция #{name} успешно создана."
    rescue RuntimeError => e
      puts e.message
     retry
  end

  #создавать поезда
  def new_train
    id = ask("Введите номер поезда, согласно формата ххх-хх")
    company = ask("Введите название производителя поезда")
    type = ask("Введите тип поезда: пассажирский или грузовой")
    if type == "пассажирский"
      @trains << TrainPassenger.new(id)
    else
      @trains << TrainCargo.new(id)
    end
    puts "#{type.capitalize} поезд #{id} успешно создан. Производитель: #{company}."
    rescue RuntimeError => e
      puts e.message
      retry
  end

  #создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def new_route
    start_station = ask("Введите начало маршрута")
    finish_station = ask("Введите конец маршрута")
    @routes << Route.new(find_station(start_station), find_station(finish_station))
    puts "Маршрут с начальной станцией #{start_station} и конечной станцией #{finish_station} успешно создан."
  end

  def add_station
    station = ask("Введите название станции")
    start_station = ask("Введите начало маршрута")
    finish_station = ask("Введите конец маршрута")
    route(start_station, finish_station).add_new_station(find_station(station))
  end

  def delete_station
    station = ask("Введите название станции")
    start_station = ask("Введите начало маршрута")
    finish_station = ask("Введите конец маршрута")
    route(start_station, finish_station).delete_station(find_station(station))
  end

  #назначать маршрут поезду

  def set_route
    start_station = ask("Введите начало маршрута")
    finish_station = ask("Введите конец маршрута")
    id = ask("Введите номер поезда")
    train(id).take_route(route(start_station, finish_station))
    find_station(start_station).take_train(train(id))
  end
  
  #добавлять вагоны к поезду
  def add_wagon
    number = ask("Введите номер вагона")
    company = ask("Введите название производителя поезда")
    wagon_type = ask("Введите тип вагона: пассажирский или грузовой")
    if wagon_type == "пассажирский"
      wagon = WagonPassenger.new(number)
    else
      wagon = WagonCargo.new(number)
    end
    id = ask("Введите номер поезда, к которому нужно прицепить вагон")
    train(id).add_wagon(wagon)
  end

  #отцеплять вагоны от поезда
  def delete_wagon
    number = ask("Введите номер вагона")
    id = ask("Введите номер поезда, от которого нужно отцепить вагон")
    train(id).delete_wagon(wagon_of_train(id, number))
  end

  #перемещать поезд по маршруту вперед и назад
  def move_forward
    id = ask("Введите номер поезда")
    start_station = ask("Введите начальную станцию")
    finish_station = ask("Введите конечную станцию")
    train(id).forward
    train(id).current_station.take_train(train(id))
    train(id).previous_station.send_train(train(id))
  end

  def move_back
    id = ask("Введите номер поезда")
    start_station = ask("Введите начальную станцию")
    finish_station = ask("Введите конечную станцию")
    train(id).back
    train(id).current_station.take_train(train(id))
    train(id).previous_station.send_train(train(id))
  end

  #просматривать список станций и список поездов на станции
  def list_stations
    start_station = ask("Введите начало маршрута")
    finish_station = ask("Введите конец маршрута")
    route(start_station, finish_station).show_route
  end

  def list_trains
    station_name = ask("Введите название станции")
    type = ask("Введите тип поезда (пассажирский или грузовой)")
    find_station(station_name).train_list(type)
  end

  private

  def ask(question)
    puts question
    gets.chomp
  end

  def find_station(station)
    @stations.find { |item| item.name == station} 
  end

  def route(start_station, finish_station)
    @routes.find { |route| route.first_station.name == start_station && route.last_station.name == finish_station}
  end 

  def train(id)
    @trains.find { |train| train.id == id}
  end 

  def wagon_of_train(id, number) 
    train(id).wagons.find{ |wagon| wagon.number == number} 
  end

end

Main.new.program