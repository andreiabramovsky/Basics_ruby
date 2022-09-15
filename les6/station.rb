class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name) #имеет название, которое указывается при создании
    @name = name
    @trains = []
    @@stations << self
    self.register_instance
  end

  def take_train(train) #может принимать поезда
    trains << train
  end

  
  def train_list(type) #может поазывать список id поездов по типу
    trains.each { |train| puts train.id if train.type == type }
  end

  def send_train(train) #может отправлять поезда
    if trains.include?(train)
      trains.delete(train)
    end
  end

end