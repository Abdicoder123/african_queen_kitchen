# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding database"
AdminUser.destroy_all
Menu.destroy_all
Dish.destroy_all
Order.destroy_all
OrderDish.destroy_all

# Create sample menus
menus = Menu.create!([
  { title: 'Appetizers' },
  { title: 'Soups & Salads' },
  { title: 'Sandwiches' },
  { title: 'Entrees' },
  { title: 'Sides' },
  { title: 'Beverages' }
])

# Create sample dishes associated with menus
dishes = Dish.create!([
  { menu_id: menus[0].id, title: 'Sambosas', description: 'Also known as samosas, a crispy pastry that comes in 9 varieties', customizable: 'Options Available: beef, chicken, tuna, shrimp, potatos, lentils, spinach, mixed vegetables, and cream cheese coconut with raisins', price: 1.75 },
  { menu_id: menus[0].id, title: 'Chicken Wings', description: 'Deep fried with BBQ and Buffalo sauces, 6pcs', price: 8.95 },
  { menu_id: menus[0].id, title: 'Bhajiya', description: "Made with black-eyed peas, onion, garlic, and African Queens' own special mixture, soaked overnight and flash-fried for a delicious and traditional starter", price: 1.50 },
  { menu_id: menus[1].id, title: 'Lentil Soup', description: "This creamy soup is prepared with garlic, onion, cilantro, tomatoes, red pepper, and African Queens' special mix", price: 5.95 },
  { menu_id: menus[1].id, title: 'Chicken Soup', description: "Made with potatoes, carrots, onion, tomatoes, garlic and cilantro, then delicately spiced for a hearty, savory soup", price: 6.95 },
  { menu_id: menus[1].id, title: 'Goat Soup', description: "A broth-based soup with cabbage, potato, carrots, onion, garlic, tomatoes, green onion, japaleño, and mouth-watering spices", price: 7.95 },
  { menu_id: menus[1].id, title: 'Garden Salad', description: "A refreshing mix of lettuce, tomatoes, red onion, carrots and mixed pepper with choice of dressing.", customizable: "Add-ons available: chicken breast, steak or tuna", price: 9.95 },
  { menu_id: menus[2].id, title: 'Philly Sandwich', description: "Steak or chicken, served with sauteed onion mixed and provolone on french bread with your choice of lettuce, tomatoes, mayo and pickles", price: 9.95 },
  { menu_id: menus[2].id, title: 'Fish Sandwich', description: "Steak or chicken, served with sauteed onion mixed and provolone on french bread with your choice of lettuce, tomatoes, mayo and pickles", price: 10.95 },
  { menu_id: menus[2].id, title: 'African Queens Wrap', description: 'Build-your-own: Choose a tortilla, whole wheat or spinach wrap to pile with your favorite fillings:', customizable: 'chicken, beef, fish, spinach, beans, green pepper, brown rice, tomatoes, onion, cheese (blue, pepper jack, mozzarella, and provolone), and your choice of sauce.', price: 10.95 },
  { menu_id: menus[3].id, title: 'Foul', description: 'Fava, northern, or red kidney beans prepared with tomatoes, onion, cilantro, jalapeño, and spice mixture with choice of anjeri or whole wheat bread.', price: 9.95 },
  { menu_id: menus[3].id, title: 'Somali Stew', description: 'Beef or chicken with onion, tomatoes, green pepper, and savory spices.', customizable: 'Served with anjeri or whole wheat bread.', price: 10.95 },
  { menu_id: menus[3].id, title: 'Omelet', description: 'Eggs, pepper mix, tomatoes, spinach, and onion with anjeri or whole wheat bread.', customizable: "Choose from Anjeri or Whole whet bread", price: 10.95 },
  { menu_id: menus[3].id, title: 'Oatmeal', description: 'Served with brown sugar and raisins.', price: 8.95 },
  { menu_id: menus[3].id, title: 'Pasta', description: 'Linguini or angel hair pasta served with tomato-based vegetable or beef sauce, with options to add chicken, beef suqaar, or salmon.', price: 10.95 },
  { menu_id: menus[3].id, title: 'Baris', description: 'A Somali specialty: basmati rice served with tender goat meat and mixed vegetables.', price: 10.95 },
  { menu_id: menus[3].id, title: 'Grits', description: 'Creamy grits served with choice of chicken or beef stew.', price: 7.95 },
  { menu_id: menus[3].id, title: 'Moofo', description: 'Somali flatbread, freshly baked and served with choice of chicken or beef stew and a side of soup or salad.', price: 7.95 },
  { menu_id: menus[3].id, title: 'Red Chori', description: 'Boiled red beans served with a brown bean and rice mixture or brown bean and chopped corn mixture.', price: 7.95 },
  { menu_id: menus[3].id, title: 'Juwar', description: 'Gluten-free grain boiled and served with olive oil, milk and honey, or sesame seed oil.', price: 7.95 },
  { menu_id: menus[3].id, title: 'Coconut Fish', description: 'A thick, creamy stew prepared with tuna, coconut, onion, garlic, curry, spices, potato, carrots, and peas. Comes with a side salad and white rice.', price: 15.95 },
  { menu_id: menus[3].id, title: 'Lasagna', description: 'Red sauce with ground beef, cheddar, mozzarella cheese, and a special spice mixture.', price: 14.95 },
  { menu_id: menus[3].id, title: 'Moong', description: 'A healthy dinner option traditionally eaten with honey, milk, and a little olive oil.', price: 7.95 },
  { menu_id: menus[4].id, title: 'Fruits', description: 'A seasonal mixture of fresh fruit.', price: 8.95 },
  { menu_id: menus[4].id, title: 'Fried Fish', description: "Choice of catfish, tilapia, or tuna, prepared with olive oil and African Queen' signature spices.", price: 12.95 },
  { menu_id: menus[4].id, title: 'Mixed Vegetables', description: 'Sautéed medley of cabbage, potato, carrots, green beans, onion, garlic, and curried spices.', price: 10.95 },
  { menu_id: menus[5].id, title: 'Somali Tea', description: 'Traditionally prepared black tea.', price: 2.50 },
  { menu_id: menus[5].id, title: 'Coffee', description: 'Traditionally prepared black coffee.', price: 2.00 },
  { menu_id: menus[5].id, title: 'Smoothie', description: 'Choose from mango, strawberry, peach, wild berry, banana, pineapple, or papaya.', price: 9.00 }
])









AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
