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
Menu.destroy_all
Dish.destroy_all
Order.destroy_all
OrderDish.destroy_all

# Create sample menus
menus = Menu.create!([
  { title: 'Italian Cuisine', description: 'A variety of Italian dishes', category: 'Cuisine' },
  { title: 'Salads', description: 'Fresh and healthy salads', category: 'Appetizer' }
])

# Create sample dishes associated with menus
dishes = Dish.create!([
  { menu_id: menus[0].id, title: 'Pasta', price: 12.50 },
  { menu_id: menus[1].id, title: 'Salad', price: 8.75 }
])

# Create sample orders
orders = Order.create!([
  { user_id: 8, delivery_date: '2025-01-25', status: 'pending', event_details: 'Office catering', group_size: 30, total_cost: 450.00 },
  { user_id: 8, delivery_date: '2025-01-26', status: 'confirmed', event_details: 'Birthday party', group_size: 20, total_cost: 300.00 }
])

# Create sample order items (OrderDish)
OrderDish.create!([
  { order_id: orders[0].id, dish_id: dishes[0].id, quantity: 10, price: 125.00 },
  { order_id: orders[1].id, dish_id: dishes[1].id, quantity: 5, price: 43.75 }
])





