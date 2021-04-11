require 'time'

class Datum
  attr_accessor :id, :meta

  singleton_class.send(:attr_accessor, :last_id)

  def initialize(attributes = {})
    @id = calculate_id
    @meta = {}
    self.class.attributes.each do |key|
      self.send("#{key}=", attributes[key.to_sym])
    end
  end

  # Class methods
  class << self
    def last_id
      @last_id || 0
    end

    def next_id
      last_id + 1
    end

    def attributes
      methods = (self.instance_methods - self.superclass.instance_methods).map(&:to_s)
      methods.select { |method| !method.end_with?('=') && methods.include?(method + '=') }
    end
  end

  # AutoIncrement id
  def calculate_id
    self.class.last_id += 1
  end

  %w(created_at updated_at completed_at cancelled_at).each do |method|
    define_method(method.to_sym) do
      @meta[method.to_sym]
    end

    # Uncomment only if writer to meta is needed
    # define_method("#{method}=") do |value|
    #   @meta[method.to_sym] = value
    # end
  end
end
