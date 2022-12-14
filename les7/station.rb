class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@stations = []

  def initialize(name) #имеет название, которое указывается при создании
    @name = name
    @trains = []
    @@stations << self
    self.register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false  
  end

  def self.all
    @@stations
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

  private

  def validate!
    raise "Не указано название станции" if name == ""
  end

end