class WagonPassenger

  attr_reader :type, :number

  def initialize(number)
    @number = number
    @type = "passenger"
  end
end