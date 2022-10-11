# Station

# class Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name, :presence

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

end
