# Station

# class Station
class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def trains_on_station(&block)
    trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.all
    @@stations
  end

  # может принимать поезда
  def take_train(train)
    trains << train
  end

  # может показывать список id поездов по типу
  def train_list(type)
    trains.each { |train| puts train.id if train.type == type }
  end

  # может отправлять поезда
  def send_train(train)
    trains.delete(train) if trains.include?(train)
  end

  private

  def validate!
    raise 'Не указано название станции' if name == ''
  end
end
