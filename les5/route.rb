class Route

  attr_reader :stations_list

  def initialize(start_station, finish_station) #имеет начальную и конечную станции
    @stations_list = []
    @stations_list[0] = start_station
    @stations_list[1] = finish_station
  end

  def show_route #может выводить список всех станций
    @stations_list.each { |station_name| puts station_name.station_name}
  end

  private

  def add_new_station(station_name) #может добавлять промежуточную станцию
    @stations_list.insert(-2, station_name) #добавить в массив после элемента с индексом -2
  end

  def delete_station(station_name) #может удалять промежуточную станцию
    if (station_name == @stations_list[0]) || (station_name == @stations_list[-1])
      puts "Нельзя удалить начальную и конечную станции"
    else @stations_list.include?(station_name)
      @stations_list.delete(station_name)
    end
  end

end