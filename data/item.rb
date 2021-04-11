require_relative 'datum'

class Item < Datum
  attr_accessor :name, :amount, :user

  def initialize(attributes = {})
    super
    $items << self
  end

  class << self
    def find(name)
      $items.find { |i| i.name == name }
    end
  end
end
