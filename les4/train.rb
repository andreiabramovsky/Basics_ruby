class Train
    attr_reader :id, :type, :railway_carryage, :speed, :cur_station, :pre_station, :next_station

    def initialize(id, type, railway_carryage)
        @id = id
        @type = type
        @railway_carryage = railway_carryage
        @speed = 0
    end

    def speed_up(speed)
        @speed = speed
    end
    
    def current_speed(speed)
        @speed = speed
    end

    def speed_down
        @speed = 0
    end

    def railway_carryage
        puts "Всего вагонов - #{@railway_carryage}"
    end

    def add_carryage
        if self.speed == 0
            self.railway_carryage += 1
        end
    end

    def del_carryage
        if self.speed == 0
            self.railway_carryage -= 1
        end
    end

    def take_route(route)
        @route = route
        @cur_station = route.station_list[0]
        @pre_station = "Вы на первой станции маршрута"
        @next_station = route.station_list[1]
    end

    def forward
        if @route == nil
        puts "Выберите маршрут"
        elsif @cur_station = @route.stations_list[-1]
        puts "Вы прибыли на конечную станцию"
        else @pre_station = @cur_station
        @cur_station = @route.station_list[@route.station_list.index(@cur_station) + 1]
        @next_station = @route.station_list[@route.station_list.index(@cur_station) + 1]
        end
    end
        
    def back
        if @route == nil
        puts "Выберите маршрут"
        elsif @cur_station = @route.stations_list[0]
        puts "Вы на начальной станции маршрута"
        else @pre_station = @cur_station
        @cur_station = @route.station_list[@route.station_list.index(@cur_station) - 1]
        @next_station = @route.station_list[@route.station_list.index(@cur_station) - 1]
        end
    end

    def where
        puts "Current station - #{@cur_station}"
        puts "Previous station - #{@pre_station}"
        puts "Next station - #{@next_station}"
    end

end