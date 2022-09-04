require_relative 'route'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'train_passenger.rb'
require_relative 'train_cargo.rb'
require_relative 'wagons_cargo.rb'
require_relative 'wagons_passenger.rb'

class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  #создавать станции
  def new_station

  end

  #создавать поезда
  def new_train
    
  end

  #создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def new_route
    
  end

  #назначать маршрут поезду
  def set_route
    
  end
  
  #добавлять вагоны к поезду
  #отцеплять вагоны от поезда
  #перемещать поезд по маршруту вперед и назад
  #просматривать список станций и список поездов на станции

end 