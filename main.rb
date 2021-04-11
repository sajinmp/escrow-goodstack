require_relative 'input_collection'

# Global store for data classes
$errors, $users, $accounts, $transactions, $items, $orders, $order_items, $escrows = 8.times.map { Array.new }

## Input format
# Buyer 1 | Credit | 20
# Seller 1 | Offer | Coffee, 3
# Buyer 1 | Order | T-Shirt
# Buyer 1 | Deposit | 10
# Buyer 2 | Order | Hoody
# Buyer 1 | Complete | T-Shirt
# Buyer 2 | Cancel | Hoody

puts <<~FORMAT
# Format
Buyer/Seller | Credit/Offer/Order/Deposit/Complete/Cancel | Item/Amount split by ,

# Example
Buyer 1 | Credit | 20
Seller 1 | Offer | Coffee, 3
END

Enter the input below.

FORMAT

InputCollection.new(gets("END").strip)
