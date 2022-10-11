# Accessors

# module Accessors
module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  #  module ClassMethods
  module ClassMethods
    # динамически создает геттеры и сеттеры для любого 
    # кол-ва атрибутов, при этом сеттер сохраняет все значения 
    # инстанс-переменной при изменении этого значения
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym # а -> :@a переменная
        # getter
        define_method("#{name}".to_sym) do
          instance_variable_get(var_name)
        end
        # setter
        define_method("#{name}=".to_sym) do |value|
          instance_eval "@#{name}_history ||= []"
          instance_variable_set(var_name, value)
          instance_eval "@#{name}_history << value"
        end
      end
    end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}".to_sym # а -> :@a переменная
        # getter
        define_method("#{name}".to_sym) do
          instance_variable_get(var_name)
        end
        # setter
        define_method("#{name}=".to_sym) do |value| 
          raise 'Тип присваиваемого значения не соответствует заданному' unless value.class == name_class
          instance_variable_set(var_name, value)
        end
    end
  end

  # module InstanceMethods
  module InstanceMethods
    # <имя_атрибута>_history возвращает массив (присвоенный переменной @<имя_атрибута>_history) всех значений переменной @name
    def method_missing(name)
      if name =~ /_history$/
        instance_variable_get("@#{name}".to_sym)
      else
        raise NoMethodError.new("Такого метода нет")
      end
    end
  end
end
