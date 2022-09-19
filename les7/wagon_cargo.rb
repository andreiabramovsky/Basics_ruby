class WagonCargo < Wagon
  attr_reader :type, :number

  def initialize(number)
    super
    @type = "грузовой"
  end
end