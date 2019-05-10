# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(username: "robby", email: "rob@test.com", password: "hello1", full_name: "Roddy Baby")
user2 = User.create(username: "rocky", email: "rocky@test.com", password: "adrian1", full_name: "Rocky Balboa")
user3 = User.create(username: "wonka", email: "wonka@test.com", password: "candy22", full_name: "Thanos Wonka")
user4 = User.create(username: "robby23", email: "rob23@test.com", password: "hello11", full_name: "Toddy Hotty")
user5 = User.create(username: "rocky23", email: "rocky23@test.com", password: "adrian11", full_name: "Rocky Roaddy")
user6 = User.create(username: "wonka23", email: "wonka23@test.com", password: "candy23", full_name: "Sam Sammy")

cat1 = Category.new("Sports")
cat2 = Category.new("Health")
cat3 = Category.new("Community")
cat4 = Category.new("Food")

event1 = user1.events.create(name: " Chattoga County Health Fair",  location: "Summerville Senior Center", description: "Education and Inservice about Hypertension with Free Health Screen", start_date: Faker::Date.forward(365), end_date: Faker::Date.forward(365), category_id: cat2.id, category_attributes: ["Health"])
event2 = user2.events.create(name: " Boxing for Winners not Weiners",  location: "Phillips Center", description: "Boxing Conference to use Boxing to lose weight and train not to get beat up in a fight ", start_date: Faker::Date.forward(365), end_date: Faker::Date.forward(365), category_id: cat2.id, category_attributes: ["Sports"] )
event3 = user3.events.create(name: " Candy Event", location: "Willy Wonka Factory", description: "For The love of Candy , Candy Making and Technique", start_of_event: Faker::Date.forward(365), end_of_event: Faker::Date.forward(365),category_id: cat4.id, category_attributes: ["Food"])
event4 = user4.events.create(name: " Floyd County Fair",  location: "Floyd Park Center", description: "Its The COUNTY fair , Funnel Cake and Safe rides ", start_date: Faker::Date.forward(365), end_date: Faker::Date.forward(365), category_id: cat3.id, category_attributes: ["Community"])
event5 = user5.events.create(name: " Playoff Basketball",  location: "Phillips Center", description: "Eastern  Conference Finals ", start_date: Faker::Date.forward(365), end_date: Faker::Date.forward(365),category_id: cat1.id, category_attributes: ["Sports"] )
event6 = user6.events.create(name: " Meetup Event", location: "Starbucks Cheesecake Factory", description: "Tech Meetup and dessert", start_of_event: Faker::Date.forward(365), end_of_event: Faker::Date.forward(365),  category_id: cat3.id, category_attributes: ["Community"])




user2.rsvp_events.create(event: event1)
user1.rsvp_events.create(event: event3)
user3.rsvp_events.create(event: event2)
user4.rsvp_events.create(event: event1)
user5.rsvp_events.create(event: event2)
user6.rsvp_events.create(event: event3)