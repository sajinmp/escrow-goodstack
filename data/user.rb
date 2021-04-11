require_relative 'datum'
require_relative 'account'
require_relative 'item'
require_relative 'order'
require 'forwardable'

class User < Datum
  extend Forwardable

  attr_accessor :name, :account, :orders, :items

  def_delegators :@account, :credit, :debit, :debitable, :balance

  def initialize(attributes = {})
    super
    @account = Account.new(balance: 0)
    @orders, @items = [[], []]
    $users << self
  end

  # Class methods
  class << self
    def find(name)
      $users.find { |user| user.name == name }
    end
  end

  def create_item(item, amount)
    item = Item.new(name: item, amount: amount, user: self)
    @items << item
  end

  def order(item, state = 'create')
    unless order_item = Item.find(item) 
      $errors << "#{item} not found for #{@name}"
    else
      send("#{state}_order", order_item)
    end
  end

  def create_order(item)
    if debitable(item.amount)
      @orders << Order.new(amount: item.amount, item: item, user: self)
      debit(item.amount)
    else
      $errors << "#{@name} doesn't have sufficient balance to purchase #{item.name}"
    end
  end

  def complete_order(item)
    check_and_act_on_order(item, 'complete')
  end

  def cancel_order(item)
    check_and_act_on_order(item, 'cancel')
  end

  def check_and_act_on_order(item, action = 'complete')
    unless order = @orders.find { |order| order.item == item }
      $errors << "#{@name} has not ordered #{item}"
    else
      order.send(action)
    end
  end
end
