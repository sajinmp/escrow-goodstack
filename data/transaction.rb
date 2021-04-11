require_relative 'datum'

class Transaction < Datum
  attr_accessor :type, :amount, :balance

  def initialize(attributes = {})
    super
    @meta[:created_at] = Time.now
    $transactions << self
  end
end
