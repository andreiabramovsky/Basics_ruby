# Validation

# module Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module ClassMethods
  module ClassMethods
    attr_writer :validations

    def validations
      @validations ||= []
    end

    def validate(attr_name, validation_type, parameter=nil)
      validations << ({ attr_name: attr_name, validation_type: validation_type, parameter: parameter })
    end
  end

  # module InstanceMethods
  module InstanceMethods
    def validate!
      if self.class.superclass == Object
        src = self.class
      else
        src = self.class.superclass
      end      
      src.validations.each do |validation|
        check_validity(validation[:attr_name], validation[:validation_type], instance_variable_get("@#{validation[:attr_name]}"), validation[:parameter])
      end
    end

    def check_validity(attr_name, type, attr_value, parameter)
      case type
      when :presence
        if attr_value.class == String
          raise "Ошибка: не указано значение #{attr_name.to_s}." if attr_value.nil? || attr_value.empty?
        end
      when :type
        raise "Ошибка: значение #{attr_name.to_s} не соответствует заданному типу #{parameter.to_s}." if attr_value.class != parameter
      when :format
        raise "Ошибка: #{attr_name.to_s} не соответствует заданному формату." if attr_value !~ parameter
      end
    end  

    def valid?
      validate!
      true
    rescue StandardError
      false  
    end
  end
end
