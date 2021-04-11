require './spec/test_config'

describe 'Users:' do
  describe 'New user:' do
    it 'should have account with 0 balance and be added to collection' do
      user = User.new
      expect(user.account).not_to be_nil
      expect(user.balance).to eq(0)
      expect($users.include?(user)).to be true
    end
  end

  describe 'Finding a user' do
    it 'should return user if present in collection' do
      user = User.new(name: "User #{User.next_id}")
      expect(User.find("User #{User.last_id}")).not_to be_nil
    end

    it 'should return nil if user not present' do
      expect(User.find(name: 'Sajin')).to be_nil
    end
  end

  describe 'Actions on user' do
    before { @user = $users.sample }
    describe 'Creating an item' do
      it 'should add a record to items' do
        expect { @user.create_item("Item #{Item.next_id}", 10) }.to change { @user.items.count }.by(1)
      end
    end

    describe 'Creating an order' do
      it 'should add to errors if item does not exist' do
        expect { @user.order('Something') }.to change { $errors.size }.by(1)
      end

      it 'should add record to orders if balance is sufficient' do
        item = $items.sample
        @user.credit(item.amount)
        expect { @user.order(item.name) }.to change { @user.orders.count }.by(1)
      end

      it 'should add to errors if balance is insufficient' do
        item = $items.sample
        @user.account.balance = 0
        expect { @user.create_order(item) }.to change { $errors.size }.by(1)
      end
    end
  end
end
