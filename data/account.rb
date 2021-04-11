require_relative 'datum'
require_relative 'transaction'

class Account < Datum
  attr_accessor :balance, :transactions

  def initialize(attributes = {})
    super
    @transactions = []
    @meta[:updated_at] = Time.now
    $accounts << self
  end

  def balance
    @balance || 0.0
  end

  def credit(amount)
    transaction = Transaction.new(
                    type: 'credit',
                    amount: amount,
                    balance: balance + amount
                  )
    @transactions << transaction
    self.balance += amount
    self.meta[:updated_at] = Time.now
  end

  def debit(amount)
    transaction = Transaction.new(
                    type: 'debit',
                    amount: amount,
                    balance: balance - amount
                  )
    @transactions << transaction
    @balance -= amount
    @meta[:updated_at] = Time.now
  end

  def debitable(amount)
    balance >= amount
  end
end
