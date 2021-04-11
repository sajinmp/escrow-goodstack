require './spec/test_config'

describe 'Input tests' do
  
  context 'When input is Sajin | Credit | 40' do
    it 'should add Sajin and credit 40 to his account' do
      InputData.new('Sajin', 'Credit', ['40'])
      user = User.find('Sajin')
      expect(user).not_to be_nil
      expect(user.balance).to eq(40.to_f)
    end
  end

  context 'When input is Seller | Offer | Laptop, 10' do
    it 'should add Seller and Item' do
      InputData.new('Seller', 'Offer', ['Laptop', '10'])
      InputData.new('Seller', 'Offer', ['Mobile', '10'])
      user = User.find('Seller')
      item = Item.find('Laptop')
      expect(user).not_to be_nil
      expect(item).not_to be_nil
      expect(item.amount).to eq(10.to_f)
    end
  end

  context 'When input is Sajin | Order | Laptop' do
    it 'should create order and move money from user to escrow' do
      escrow_balance = Escrow.balance
      InputData.new('Sajin', 'Order', ['Laptop'])
      user = User.find('Sajin')
      order = user.orders.last
      expect(order).not_to be_nil
      expect(user.balance).to eq(30.to_f)
      expect(Escrow.balance - escrow_balance).to eq(order.amount)
    end
  end

  context 'When input is Sajin | Complete | Laptop' do
    it 'should complete order and move money from escrow to seller' do
      escrow_balance = Escrow.balance
      user = User.find('Sajin')
      order = user.orders.last
      seller_balance = order.item.user.balance
      InputData.new('Sajin', 'Complete', ['Laptop'])
      new_seller_balance = order.item.user.balance
      expect(order.status).to eq('completed')
      expect(escrow_balance - Escrow.balance).to eq(order.amount)
      expect(new_seller_balance - seller_balance).to eq(order.amount)
    end
  end

  context 'When input is Sajin | Order | Mobile' do
    it 'should create order and move money from user to escrow' do
      escrow_balance = Escrow.balance
      InputData.new('Sajin', 'Order', ['Mobile'])
      user = User.find('Sajin')
      order = user.orders.last
      expect(order).not_to be_nil
      expect(user.balance).to eq(20.to_f)
      expect(Escrow.balance - escrow_balance).to eq(order.amount)
    end
  end

  context 'When input is Sajin | Cancel | Mobile' do
    it 'should cancel order and return money to user from escrow' do
      escrow_balance = Escrow.balance
      InputData.new('Sajin', 'Cancel', ['Mobile'])
      user = User.find('Sajin')
      order = user.orders.last
      expect(order.status).to eq('cancelled')
      expect(user.balance).to eq(30.to_f)
      expect(escrow_balance - Escrow.balance).to eq(order.amount)
    end
  end
end
