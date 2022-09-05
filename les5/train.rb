class Train
    attr_reader :id, :type, :speed, :wagons, :current_station, :previous_station, :next_station

    def initialize(id) 
      @id = id
      @type = type
      @speed = 0
      @wagons = []
    end

    def speed_up(speed) #может набирать скорость
      @speed = speed
    end
    
    def current_speed #может возвращать текущую скорость
      @speed = speed
    end

    def speed_down #может тормозить
      @speed = 0
    end

    def take_route(route) #может принимать маршрут
      @route = route
      @current_station = route.stations_list[0]
      @previous_station = "Вы на первой станции маршрута"
      @next_station = route.stations_list[1]
    end

    def forward #может перемещаться по маршруту вперед
      if @route == nil
        puts "Выберите маршрут"
      elsif @current_station == @route.stations_list[-1]
        puts "Вы прибыли на конечную станцию"
      else
        @previous_station = @current_station
        @current_station = @route.stations_list[@route.stations_list.index(@current_station) + 1]
        @next_station = @route.stations_list[@route.stations_list.index(@current_station) + 1]
      end
    end
        
    def back #может перемещаться по маршруту назад
        if @route == nil
          puts "Выберите маршрут"
        elsif @current_station == @route.stations_list[0]
          puts "Вы на начальной станции маршрута"
        else
          @previous_station = @current_station
          @current_station = @route.stations_list[@route.stations_list.index(@current_station) - 1]
          @next_station = @route.stations_list[@route.stations_list.index(@current_station) - 1]
        end
    end

    def where #может возвращать предыдущую, текущую, следующую станции по маршруту
      puts "Current station - #{@current_station}"
      puts "previousvious station - #{@previous_station}"
      puts "Next station - #{@next_station}"
    end

end