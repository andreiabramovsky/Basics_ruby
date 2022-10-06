# InstanceCounter

# module InstanceCounter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # module ClassMethods
  module ClassMethods
    def define_instances_count
      @instances_count ||= 0
      class << self
        attr_accessor :instances_count
      end
    end

    def instances
      @instances_count
    end
  end

  # module InstanceMethods
  module InstanceMethods
    private

    def register_instance
      self.class.define_instances_count
      self.class.instances_count += 1
    end
  end
end
