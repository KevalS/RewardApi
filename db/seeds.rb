client_1 = Client.create!(name: "ShopCustom_1", email: "support@shopcustomone.com", password: "123123123")
client_2 = Client.create!(name: "ShopCustom_2", email: "support@shopcustomtwo.com", password: "123123123")
client_3 = Client.create!(name: "ShopCustom_3", email: "support@shopcustomthree.com", password: "123123123")

p "CLIENTS CREATED"

client_1_customer_1 = client_1.customers.create(name: "customer_1", email: "customer_1@example1.com", dob: (Date.today - 10.years) ) 
client_1_customer_2 = client_1.customers.create(name: "customer_2", email: "customer_2@example2.com", dob: (Date.today - 10.years) )
client_1_customer_3 = client_1.customers.create(name: "customer_3", email: "customer_3@example3.com", dob: (Date.today - 10.years) )

client_2_customer_1 = client_2.customers.create(name: "customer_1", email: "customer_1@example1.com", dob: (Date.today - 10.years) )
client_2_customer_2 = client_2.customers.create(name: "customer_2", email: "customer_2@example2.com", dob: (Date.today - 10.years) )
client_2_customer_3 = client_2.customers.create(name: "customer_3", email: "customer_3@example3.com", dob: (Date.today - 10.years) )

client_2_customer_1 = client_3.customers.create(name: "customer_1", email: "customer_1@example1.com", dob: (Date.today - 10.years) )
client_2_customer_2 = client_3.customers.create(name: "customer_2", email: "customer_2@example2.com", dob: (Date.today - 10.years) )
client_2_customer_3 = client_3.customers.create(name: "customer_3", email: "customer_3@example3.com", dob: (Date.today - 10.years) )

p "CUSTOMER CREATED"

Reward.create(name: "Monthly Reward", description: "free cofee reward for completing a transactions of compined amount more than 100$ per month")
Reward.create(name: "Birthday Reward", description: "complementery reward for customers birthday month")
Reward.create(name: "Cash Rebate Reward", description: "reward for completing 10 or more transaction that have an amount greater $100")
Reward.create(name: "Movie Reward",description: "Free Movie Tickets reward for completing trasactions of compined amount $1000 within 60 days of their first transaction" )
Reward.create(name: "Airport Reward",description: "Give 4x Airport Lounge Access Reward when a user becomes a gold tier customer")
Reward.create(name: "Quarterly Reward", description: "100 loyalty points per quarter if trasction exeeds total 2000 that quarter")

p "REWARDS CREATED"

Tier.create(name: "Standard", priority: 1)
Tier.create(name: "Gold", priority: 2)
Tier.create(name: "Platinum", priority: 3)

p "TIERS CREATED"
