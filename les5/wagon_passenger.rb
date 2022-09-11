class WagonPassenger < Wagon
  attr_reader :type, :number

  def initialize(number)
    super
    @type = "пассажирский"
  end
end