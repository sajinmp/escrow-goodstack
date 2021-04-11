require_relative 'datum'

class Escrow < Datum
  singleton_class.send(:attr_accessor, :balance)

  attr_accessor :amount, :status

  def initialize(attributes = {})
    super
    @status = 'created'
    @meta.merge!(created_at: Time.now, completed_at: nil, cancelled_at: nil)
    self.class.balance += amount
    $escrows << @escrow
  end

  def complete(amount)
    @status = 'completed'
    @meta[:completed_at] = Time.now
    self.class.balance -= amount
  end

  def cancel(amount)
    @status = 'cancelled'
    @meta[:cancelled_at] = Time.now
    self.class.balance -= amount
  end

  class << self
    def balance
      @balance || 0.0
    end
  end
end
