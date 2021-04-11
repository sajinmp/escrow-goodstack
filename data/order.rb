require_relative 'datum'
require_relative 'escrow'

class Order < Datum
  attr_accessor :amount, :status, :item, :escrow, :user

  def initialize(attributes = {})
    super
    @status = 'created'
    @meta.merge!(created_at: Time.now, completed_at: nil, cancelled_at: nil)
    @escrow = Escrow.new(amount: @amount)
    $orders << self
  end

  def complete
    return if completed_or_cancelled
    @status = 'completed'
    @meta[:completed_at] = Time.now
    @escrow.complete(@amount)
    item.user.credit(@amount)
  end

  def cancel
    return if completed_or_cancelled
    @status = 'cancelled'
    @meta[:cancelled_at] = Time.now
    @escrow.cancel(@amount)
    @user.credit(@amount)
  end

  def completed_or_cancelled
    if completed? || cancelled?
      $errors << "#{@user.name}'s order of #{@item.name} is already completed or cancelled."
      return true
    end
    false
  end

  def completed?
    @status == 'completed'
  end

  def cancelled?
    @status == 'completed'
  end
end
