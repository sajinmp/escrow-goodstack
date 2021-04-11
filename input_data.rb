Dir.glob('./data/*.rb') { |f| require f }

class InputData
  attr_accessor :user, :action, :params

  def initialize(*input)
    username, @action, @params = input
    @action = 'Cancel' if @action == 'Complain'
    @user = User.find(username) || User.new(name: username)
    send(action.downcase, *params)
  end

  def credit(amount)
    @user.credit(amount.to_f)
  end

  def offer(item, amount)
    @user.create_item(item, amount.to_f)
  end

  def order(item)
    @user.order(item)
  end

  def deposit(amount)
    @user.credit(amount.to_f)
  end

  def complete(item)
    @user.order(item, 'complete')
  end

  def cancel(item)
    @user.order(item, 'cancel')
  end
end
