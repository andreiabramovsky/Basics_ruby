class Route
  attr_reader :stations

  def initialize(start_station, finish_station) #имеет начальную и конечную станции
    @stations = [start_station, finish_station]
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def show_route #может выводить список всех станций
    stations.each { |station| puts station.name}
  end

  def add_new_station(station) #может добавлять промежуточную станцию
    stations.insert(-2, station) #добавить в массив после элемента с индексом -2
  end

  def delete_station(station) #может удалять промежуточную станцию
    if (station == first_station) || (station == last_station)
      puts "Нельзя удалить начальную и конечную станции"
    else stations.include?(station)
      station.delete(station)
    end
  end

end