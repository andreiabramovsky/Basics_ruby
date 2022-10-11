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
      self.class.validations.each do |validation|
        check_validity(validation[:validation_type], instance_variable_get("@#{validation[:attr_name]}"), validation[:parameter])
      end
    end

    def check_validity(type, attr_value, parameter)
      case type
      when :presence
        if attr_value.class == String
          raise "Значение не указано" if attr_value.nil? || attr_value.empty?
        end
      when :type
        raise "Значение не соответствует заданному типу." if attr_value.class != parameter
      when :format
        raise "Значение не соответствует заданному формату." if attr_value !~ parameter
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
