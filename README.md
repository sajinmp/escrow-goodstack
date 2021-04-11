# How to run
- Clone the repo
- Run `ruby main.rb`
- Enter data according to the format
- Balance of all users and escrow balance is printed

# How to test
- Run `bundle`
- Run `rspec`

# Input format
Username | Credit/Offer/Order/Deposit/Complete/Cancel | Item/Amount(split by ,)

# Sample Input
Buyer 1 | Credit | 20
Buyer 2 | Credit | 40
Seller 1 | Offer | Coffee, 3
Seller 2 | Offer | T-Shirt, 5
Seller 1 | Offer | Tea, 2.5
Seller 1 | Offer | Cake, 3.5
Seller 2 | Offer | Shorts, 8
Seller 2 | Offer | Hoody, 12
Buyer 1 | Order | T-Shirt
Buyer 1 | Deposit | 10
Buyer 2 | Order | Hoody
Buyer 1 | Complete | T-Shirt
Buyer 1 | Order | Coffee
Buyer 1 | Order | Cake
Buyer 2 | Complain | Hoody
Buyer 2 | Order | Tea
Buyer 1 | Complete | Coffee
END
