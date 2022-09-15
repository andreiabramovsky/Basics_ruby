class Wagon
  attr_reader :number

  include Company

  def initialize(number, company)
    @number = number
    @company = company
  end
end