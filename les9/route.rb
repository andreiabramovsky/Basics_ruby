# Route

# class Route
class Route
  attr_reader :stations, :start_station, :finish_station

  include InstanceCounter

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  # может выводить список всех станций
  def show_route
    stations.each { |station| puts station.name }
  end

  # может добавлять промежуточную станцию
  def add_new_station(station)
    # добавить в массив после элемента с индексом -2
    stations.insert(-2, station)
  end

  # может удалять промежуточную станцию
  def delete_station(station)
    if (station == first_station) || (station == last_station)
      puts 'Нельзя удалить начальную и конечную станции'
    else
      stations.include?(station)
      station.delete(station)
    end
  end

  private

  def validate!
    raise 'Не указана начальная станция маршрута' if start_station == ''
    raise 'Не указана конечная станция маршрута' if finish_station == ''
  end
end
