class Station

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def station_name
    @station_name
  end

  def take_train(train)
    @trains << train
  end

  def trains_list      
    puts "@trains.each { |train| puts train.id}"
  end

  def train_list_type
    cargo = @trains.count { |train| train.type == "cargo" }
    pass = @trains.count { |train| train.type == "pass" }
    puts "cargo trains - #{cargo}"
    puts "pass trains - #{pass}"
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    end
  end

end