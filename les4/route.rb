class Route

  attr_reader :stations_list

  def initialize(start_station, finish_station)
    @stations_list = []
    @station_list[0] = start_station
    @station_list[1] = finish_station
  end

  def add_station(station_name)
    @station_list.insert(-2, station_name) #добавить в массив после элемента с индексом -2
  end

  def delete_station(station_name)
    if (station_name == @station_list[0]) || (station_name == @station_list[-1])
      puts "Нельзя удалить начальную и конечную станции"
    elsif @stations_list.include?(station_name)
      @station_list.delete(station_name)
    end
  end

  def show_route
    @station_list.each { |station_name| put station_name}
  end

end