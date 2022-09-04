class Station

  attr_reader :station_name

  def initialize(station_name) #имеет название, которое указывается при создании
    @station_name = station_name
    @trains = []
  end

  def take_train(train) #может принимать поезда
    @trains << train
  end

  def trains_list #может возвращать список поездов на станции     
    puts "@trains.each { |train| puts train.id}"
  end

  def train_list_type #может возвращать список поездов по типу
    cargo = @trains.count { |train| train.type == "cargo" }
    pass = @trains.count { |train| train.type == "pass" }
    puts "cargo trains - #{cargo}"
    puts "pass trains - #{pass}"
  end

  def send_train(train) #может отправлять поезда
    if @trains.include?(train)
      @trains.delete(train)
    end
  end

end