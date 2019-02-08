# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#changed this to avoid creating duplicates on multiple 'rake db:seed' commands
categories_data = [
    {name: 'Books'},    #1
    {name: 'Video Games'},  #2
    {name: 'Electronics'},  #3
    {name: 'Home and Garden Tools'},  #4
    {name: 'Toys'},     #5
    {name: 'Clothings'},    #6
    {name: 'Sports and Outdoor Equipment'}, #7
    {name: 'Automotive'},    #8
    {name: 'Party'},     #9
    {name: 'Travel'},    #10
    {name: 'Cosmetics'}     #11
]

categories_data.each {|cat| Category.find_or_create_by(cat)}

time_period_categories_data = [
    {name: '1 minute (for DEMO)'},
    {name: '1 day'},
    {name: '3 days'},
    {name: '1 week'},
    {name: '2 weeks'},
    {name: '1 month'},
    {name: '3 months'},
    {name: '6 months'},
    {name: '1 year'}
]

time_period_categories_data.each {|tp_cat| TimePeriodCategory.find_or_create_by(tp_cat)}

#creating test data for users and items
emails = ['super1@gmail.com', 'super2@gmail.com', 'super3@gmail.com', 'super4@gmail.com',
          'super5@gmail.com', 'super6@gmail.com', 'super7@gmail.com', 'super8@gmail.com',
          'super9@gmail.com', 'super10@gmail.com']

f_names = ['Alice', 'Bob', 'Calvin', 'Dan', 'Elis', 'Fred', 'George', 'Henry', 'Ian', 'Jessica',
           'Kyle', 'Lily', 'Marvin', 'Nikki', 'Owen', 'Pom', 'Qano', 'Rachael', 'Sandra', 'Tom',
           'Ursula', 'Vince']
l_names = ['Archer', 'Bright', 'Clan', 'Derothy', 'Elane', 'Foster', 'Gems', 'Heart', 'Iverson', 'Jones',
           'Klements', 'Long', 'Mcdonalds', 'Nate', 'Odonald', 'Pace', 'Quan', 'Red', 'Sullivan', 'Teddy',
           'Ullai', 'Vaughn']
addresses = ['1 Bloor Street W', '130 St George St', '400 King St W', '77 Adelaide St W', '454 Parliament St',
             '470 Yonge St', '40 St George St', '40 Bay St, Toronto', '1 Blue Jays Way', '399 Bathurst St',
             '725 Logan Ave', '1138 Bathurst St', '600 Bloor St W', '201 Harbord St', '722 College St',
             '722 College St', '184 Augusta Ave', '200 Elizabeth St', '350 Victoria St', '410 Sherbourne St',
             '130 St George St', '100 Wellesley St W' ]
postal_codes = ['M6H 1M9', 'M5S 1A5', 'M5V 1K2', 'M5X 1C1', 'M5A 2H6', 'M4Y 1X5', 'M5S 2E4', 'M5J 2X2', 'M5V 1J1',
                'M5T 2S8', 'M4K 3B9', 'M6G 2B4', 'M6G 1K4', 'M5S 1H6', 'M6G 1C4', 'M6G 1C4', 'M5T 2L6', 'M5G 2C4',
                'M5B 2K3', 'M5X 1K2', 'M5S 1A5', 'M5S 2Z5']
ratings = [3.3, 4.5, 2.1, 2.9, 4.9, 4.3, 5.0, 4.7, 4.8, 4.4, 3.3, 4.5, 2.1, 2.9, 4.9, 4.3, 5.0, 4.7, 4.8, 4.4, 1.3, 2.1]

i = 0
n = 10

while i < n do
    user = User.new(email: emails[i], password: 'password', password_confirmation: 'password', first_name: f_names[i], 
        last_name: l_names[i], phone_number: '6471112222', street_addr: addresses[i], city: 'Toronto',
        province: 'ON', postal_code: postal_codes[i], average_rating: ratings[i])
    user.skip_confirmation!
    user.save!
    i = i + 1
end

#Admin
user = User.new(email: 'admin@gmail.com', password: 'password', password_confirmation: 'password', first_name: 'Admin',
                last_name: 'boss', phone_number: '6471112222', street_addr: '', city: 'Toronto',
                province: 'ON', postal_code: postal_codes[i], average_rating: ratings[i])
user.skip_confirmation!
user.save!

t_items = [
    {description: 'drill', times_used: 7, available: true, taken: false, user_id: 1, category_id: 4},           #1
    {description: 'textbook', times_used: 12, available: true, taken: false, user_id: 2, category_id: 1},       #2
    {description: 'movie cd', times_used: 4, available: true, taken: false, user_id: 3, category_id: 3},        #3
    {description: 'hair dryer', times_used: 2, available: true, taken: false, user_id: 1, category_id: 4},      #4
    {description: 'basketball', times_used: 26, available: true, taken: false, user_id: 3, category_id: 7},     #5

    {description: 'ferrari', times_used: 8, available: true, taken: true, user_id: 3, category_id: 8},          #6
    {description: 'coat', times_used: 3, available: true, taken: true, user_id: 3, category_id: 6},             #7
    {description: 'bayblade', times_used: 4, available: true, taken: true, user_id: 3, category_id: 5},         #8
    {description: 'cups', times_used: 3, available: true, taken: false, user_id: 4, category_id: 4},            #9
    {description: 'party heels', times_used: 4, available: true, taken: true, user_id: 5, category_id: 9},      #10

    {description: 'ladder', times_used: 4, available: true, taken: true, user_id: 6, category_id: 4},           #11
    {description: 'DLSR camera', times_used: 4, available: true, taken: true, user_id: 7, category_id: 7},      #12
    {description: 'coffee maker', times_used: 4, available: true, taken: true, user_id: 8, category_id: 4},     #13
    {description: 'travel bag', times_used: 4, available: true, taken: true, user_id: 9, category_id: 10},      #14
    {description: 'torch light', times_used: 4, available: true, taken: true, user_id: 10, category_id: 10},    #15

    {description: 'bike', times_used: 4, available: true, taken: false, user_id: 6, category_id: 7},            #16
    {description: 'makeup', times_used: 4, available: true, taken: false, user_id: 4, category_id: 11},         #17
    {description: 'calculator', times_used: 4, available: true, taken: false, user_id: 8, category_id: 3},      #18
    {description: 'dumbells', times_used: 4, available: true, taken: false, user_id: 9, category_id: 7},        #19
    {description: 'Mario Kart', times_used: 4, available: true, taken: false, user_id: 10, category_id: 5},     #20

    {description: 'trolley', times_used: 7, available: true, taken: false, user_id: 8, category_id: 10},        #21
    {description: 'Nice book', times_used: 8, available: true, taken: false, user_id: 9, category_id: 1},       #22
    {description: 'Avengers DVD', times_used: 5, available: true, taken: false, user_id: 7, category_id: 3},        #23
    {description: 'candle stand', times_used: 1, available: true, taken: false, user_id: 10, category_id: 4},      #24
    {description: 'baseball bat', times_used: 13, available: true, taken: false, user_id: 6, category_id: 7},     #25

]

t_images = [
    {location: 'storage/test_pictures/drill.jpeg', name: 'drill.jpeg', id: 1},
    {location: 'storage/test_pictures/textbook.jpg', name: 'textbook.jpg', id: 2},
    {location: 'storage/test_pictures/movie_cd.png', name: 'movie_cd.png', id: 3},
    {location: 'storage/test_pictures/hair_dryer.jpeg', name: 'hair_dryer.jpeg', id: 4},
    {location: 'storage/test_pictures/basket_ball.jpg', name: 'basket_ball.jpg', id: 5},
    {location: 'storage/test_pictures/ferrari.jpg', name: 'ferrari.jpg', id: 6},
    {location: 'storage/test_pictures/coat.jpg', name: 'coat.jpg', id: 7},
    {location: 'storage/test_pictures/bayblade.png', name: 'bayblade.png', id: 8},
    {location: 'storage/test_pictures/cup.jpg', name: 'cup.jpg', id: 9},
    {location: 'storage/test_pictures/partyheels.jpg', name: 'partyheels.jpg', id: 10},
    {location: 'storage/test_pictures/ladder.jpg', name: 'ladder.jpg', id: 11},
    {location: 'storage/test_pictures/dslrcamera.jpg', name: 'dslrcamera.jpg', id: 12},
    {location: 'storage/test_pictures/coffeemaker.jpg', name: 'coffeemaker.jpg', id: 13},
    {location: 'storage/test_pictures/travelbag.jpg', name: 'travelbag.jpg', id: 14},
    {location: 'storage/test_pictures/torchlight.jpeg', name: 'torchlight.jpeg', id: 15},
    {location: 'storage/test_pictures/bike.jpg', name: 'bike.jpg', id: 16},
    {location: 'storage/test_pictures/makeup.png', name: 'makeup.png', id: 17},
    {location: 'storage/test_pictures/calculator.jpeg', name: 'calculator.jpeg', id: 18},
    {location: 'storage/test_pictures/dumbell.jpg', name: 'dumbell.jpg', id: 19},
    {location: 'storage/test_pictures/mariokart.jpeg', name: 'mariokart.jpeg', id: 20},
    {location: 'storage/test_pictures/trolley.jpg', name: 'trolley.jpg', id: 21},
    {location: 'storage/test_pictures/artofprogramming.jpg', name: 'artofprogramming.jpg', id: 22},
    {location: 'storage/test_pictures/avengers.jpg', name: 'avengers.jpg', id: 23},
    {location: 'storage/test_pictures/candlestand.jpg', name: 'candlestand.jpg', id: 24},
    {location: 'storage/test_pictures/baseballbat.jpg', name: 'baseballbat.jpg', id: 25}


]

t_reviews = [
    {user_id: 1, reviewer_id: 2, rating: 3, comments: 'Hello! this is a test review'},
    {user_id: 1, reviewer_id: 4, rating: 5, comments: 'Hello! this is a test review'},
    {user_id: 1, reviewer_id: 2, rating: 2, comments: 'Hello! this is a test review'},
    {user_id: 1, reviewer_id: 3, rating: 5, comments: 'Hello! this is a test review'},
    {user_id: 1, reviewer_id: 4, rating: 4, comments: 'Hello! this is a test review'}

]

t_active_items = [
    {lender_id: 3, borrower_id: 1, start_date: DateTime.strptime("11/1/2018", "%m/%d/%Y"), due_date: DateTime.strptime("11/8/2018 8:00", "%m/%d/%Y %H:%M"), item_id: 13},
    {lender_id: 3, borrower_id: 2, start_date: DateTime.strptime("11/1/2018", "%m/%d/%Y"), due_date: DateTime.strptime("11/8/2018 8:00", "%m/%d/%Y %H:%M"), item_id: 12},
    {lender_id: 3, borrower_id: 9, start_date: DateTime.strptime("11/1/2018", "%m/%d/%Y"), due_date: DateTime.strptime("11/8/2018 8:00", "%m/%d/%Y %H:%M"), item_id: 14},

]

t_requests = [
  {created_at: DateTime.strptime("12/3/2018", "%m/%d/%Y"), updated_at: DateTime.strptime("12/3/2018", "%m/%d/%Y"), borrower_id: 1, lender_id: 2, item_id: 1, status: 0, time_period: '1 day', due_date: DateTime.strptime("12/4/2018", "%m/%d/%Y")},
  {created_at: DateTime.strptime("12/3/2018", "%m/%d/%Y"), updated_at: DateTime.strptime("12/3/2018", "%m/%d/%Y"), borrower_id: 1, lender_id: 2, item_id: 2, status: 1, time_period: '1 day', due_date: DateTime.strptime("12/4/2018", "%m/%d/%Y")},
  {created_at: DateTime.strptime("12/4/2018", "%m/%d/%Y"), updated_at: DateTime.strptime("12/4/2018", "%m/%d/%Y"), borrower_id: 2, lender_id: 1, item_id: 3, status: 0, time_period: '1 day', due_date: DateTime.strptime("12/5/2018", "%m/%d/%Y")},
  {created_at: DateTime.strptime("12/4/2018", "%m/%d/%Y"), updated_at: DateTime.strptime("12/4/2018", "%m/%d/%Y"), borrower_id: 2, lender_id: 1, item_id: 4, status: 1, time_period: '1 day', due_date: DateTime.strptime("12/5/2018", "%m/%d/%Y")},
]

#t_users.each {|user| User.where(user).first_or_create}
t_items.each {|item| Item.where(item).first_or_create}
t_reviews.each {|item| LenderReview.where(item).first_or_create}
t_reviews.each {|item| BorrowerReview.where(item).first_or_create}
t_active_items.each {|item| ActiveItem.where(item).first_or_create}
t_requests.each {|request| Request.where(request).first_or_create}

t_images.each do |image|
  user = Item.find_by_id(image[:id])
  user.image.attach(io: File.open(Rails.root + image[:location]), filename: image[:name])
end
