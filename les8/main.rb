=begin
При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
Выводить список поездов на станции (в указанном выше формате), используя  созданные методы
Занимать место или объем в вагоне
=end

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
    {id: 13, title: "показать список вагонов у поезда", action: :wagons_list},
    {id: 14, title: "занять место/объём в вагоне", action: :take_seat_or_volume}
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
      @trains << TrainPassenger.new(id, company, type)
    else
      @trains << TrainCargo.new(id, company, type)
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
    number = ask("Введите номер вагона (число от 1 до 99)")
    company = ask("Введите название производителя вагона")
    wagon_type = ask("Введите тип вагона: пассажирский или грузовой")
    if wagon_type == "пассажирский"
      total_seats = ask_integer("Введите количество мест в вагоне")
      wagon = WagonPassenger.new(number, company, total_seats)
    elsif wagon_type == "грузовой"
      total_volume = ask_integer("Введите объём грузового вагона")
      wagon = WagonCargo.new(number, company, total_volume)
    end
    id = ask("Введите номер поезда, к которому нужно прицепить вагон")
    train(id).add_wagon(wagon)
    puts "#{wagon_type.capitalize} вагон #{number}, производителя #{company} успешно создан. Вагон прицеплён к поезду #{id}"
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

  #показать список вагонов у поезда
  def wagons_list
    id = ask("Введите номер поезда")
    train(id).wagons_of_train do |wagon|
      if wagon.type == "пассажирский"
        puts "#{wagon.type.capitalize} вагон #{wagon.number}, количество свободных мест: #{wagon.get_free_seats}, количество занятых мест: #{wagon.get_occupied_seats}."
      else
        puts "#{wagon.type.capitalize} вагон #{wagon.number}, количество свободного объёма: #{wagon.get_free_volume}, количество занятого объёма: #{wagon.get_occupied_volume}."
      end
    end
  end

  def take_seat_or_volume
    id = ask("Введите номер поезда")
    number = ask("Введите номер вагона")
    if train(id).type == "пассажирский"
      wagon_of_train(id, number).take_seat
      puts "Вы заняли одно место в вагоне #{number} поезда #{id}. Всего мест #{wagon_of_train(id, number).total_seats}, свободно #{wagon_of_train(id, number).get_free_seats}."
    else
      puts "Объём вагона: #{wagon_of_train(id, number).total_volume}, свободно: #{wagon_of_train(id, number).get_free_volume}"
      volume = ask_integer("Введите объём загрузки")
      wagon_of_train(id, number).take_volume(volume)
      puts "Вы загрузили #{volume} в вагон #{number} поезда #{id}."
    end
    rescue RuntimeError => e
      puts e.message
      retry
  end

  private

  def ask(question)
    puts question
    gets.chomp
  end

  def ask_integer(question)
    puts question
    gets.chomp.to_i
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