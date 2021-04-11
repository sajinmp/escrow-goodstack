require './spec/test_config'

describe 'Orders:' do
  before { @user = $users.sample }

  describe 'New Order:' do
    it 'should have status and time and add amount to escrow' do
      item = $items.sample
      escrow_balance = Escrow.balance
      order = Order.new(item: item, user: @user, amount: item.amount)
      expect(order.status).to eq('created')
      expect(order.created_at).not_to be_nil
      expect(Escrow.balance - escrow_balance).to eq(order.amount)
    end
  end

  describe 'Completing an order' do
    before do
      item = $items.sample
      @order = Order.new(item: item, user: @user, amount: item.amount)
    end

    it 'should mark order completed and pay if status is created' do
      escrow = Escrow.balance
      seller_b = @order.item.user.balance
      @order.complete
      new_seller_b = @order.item.user.balance
      expect(@order.status).to eq('completed')
      expect(@order.completed_at).not_to be_nil
      expect(escrow - Escrow.balance).to eq(@order.amount)
      expect(new_seller_b - seller_b).to eq(@order.amount)
    end

    it 'should add error if status is not created' do
      @order.status = 'completed'
      expect { @order.complete }.to change { $errors.size }.by(1)
    end
  end

  describe 'Cancelling an order' do
    before do
      item = $items.sample
      @order = Order.new(item: item, user: @user, amount: item.amount)
    end

    it 'should mark order cancelled and refund if status is created' do
      escrow = Escrow.balance
      buyer_b = @order.user.balance
      @order.cancel
      new_buyer_b = @order.user.balance
      expect(@order.status).to eq('cancelled')
      expect(@order.cancelled_at).not_to be_nil
      expect(escrow - Escrow.balance).to eq(@order.amount)
      expect(new_buyer_b - buyer_b).to eq(@order.amount)
    end

    it 'should add error if status is not created' do
      @order.status = 'completed'
      expect { @order.complete }.to change { $errors.size }.by(1)
    end
  end
end
