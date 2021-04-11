require './input_data'

$errors, $users, $accounts, $transactions, $items, $orders, $order_items, $escrows = 8.times.map { Array.new }

5.times { |i| User.new(name: "User#{i + 1}") }
5.times { |i| Item.new(name: "Item#{i + 1}", amount: rand(20).to_f + 1, user: $users.sample) }
