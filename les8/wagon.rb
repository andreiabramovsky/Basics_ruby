class Wagon
  attr_reader :number, :total_space, :occupied_space, :free_space
  NUMBER_FORMAT = /^[1-9][0-9]?$/
  include Company

  def initialize(number, company, total_space)
    @number = number
    @company = company
    validate!
    @total_space = total_space
    @free_space = total_space
    @occupied_space = 0
  end

  def get_occupied_space
    occupied_space
  end

  def get_free_space
    free_space
  end

  def valid?
    validate!
    true
  rescue
    false  
  end

  protected

  attr_writer :occupied_space, :free_space

  def validate!
    raise "Не указан номер вагона" if number == ""
    raise "Не указано название компании изготовителя вагона" if company == ""
    raise "Неверный формат номера вагона. Укажите номер вагона от 1 до 99" if number !~ NUMBER_FORMAT
  end

end