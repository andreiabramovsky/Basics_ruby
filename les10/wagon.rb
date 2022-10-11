# Wagon

# class Wagon
class Wagon
  attr_reader :number, :total_space, :occupied_space, :free_space

  NUMBER_FORMAT = /^[1-9][0-9]?$/.freeze
  include Company
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :company, :presence
  validate :total_space, :presence

  def initialize(number, company, total_space)
    @number = number
    @company = company
    validate!
    @total_space = total_space
    @free_space = total_space
    @occupied_space = 0
  end

  protected

  attr_writer :occupied_space, :free_space
end
