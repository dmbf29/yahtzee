user = User.find_by_email('douglasmberkley@gmail.com')
unless user
  puts "Creating admin..."
  user = User.create(
    name: 'Doug',
    admin: true,
    email: 'douglasmberkley@gmail.com',
    password: ENV['DOUG_PASSWORD']
  )
  puts "#{user.name} created..."
end

user = User.find_by_email('dmbf29@gmail.com')
unless user
  puts "Creating test user..."
  user = User.create(
    name: 'dmf29',
    admin: true,
    email: 'dmbf29@gmail.com',
    password: ENV['DOUG_PASSWORD']
  )
  puts "#{user.name} created..."
end

if Rails.env.development?
  puts "Destroying categories..."
  Category.destroy_all
end

if Category.count == 0
  puts "Creating categories..."
  category_attributes = [
    {
      name: 'Aces',
      value: nil,
      top_half: true,
      place: 1,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Twos',
      value: nil,
      top_half: true,
      place: 2,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Threes',
      value: nil,
      top_half: true,
      place: 3,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Fours',
      value: nil,
      top_half: true,
      place: 4,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Fives',
      value: nil,
      top_half: true,
      place: 5,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Sixes',
      value: nil,
      top_half: true,
      place: 6,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Total (Need 63)',
      value: nil,
      top_half: true,
      place: 7,
      fixed_value: false,
      total_cell: true
    },
    {
      name: 'Bonus (35)',
      value: nil,
      top_half: true,
      place: 8,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Total Top Half',
      value: nil,
      top_half: true,
      place: 9,
      fixed_value: false,
      total_cell: true
    },
    {
      name: '3 of Kind',
      value: nil,
      top_half: false,
      place: 10,
      fixed_value: false,
      total_cell: false
    },
    {
      name: '4 of Kind',
      value: nil,
      top_half: false,
      place: 11,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Full House (25)',
      value: 25,
      top_half: false,
      place: 12,
      fixed_value: true,
      total_cell: false
    },
    {
      name: 'Sm Straight (30)',
      value: 30,
      top_half: false,
      place: 13,
      fixed_value: true,
      total_cell: false
    },
    {
      name: 'Lg Straight (40)',
      value: 40,
      top_half: false,
      place: 14,
      fixed_value: true,
      total_cell: false
    },
    {
      name: 'Yahtzee (50)',
      value: 50,
      top_half: false,
      place: 15,
      fixed_value: true,
      total_cell: false
    },
    {
      name: 'Chance (total)',
      value: nil,
      top_half: false,
      place: 16,
      fixed_value: false,
      total_cell: false
    },
    {
      name: 'Yahtzee Bonus',
      value: 100,
      top_half: false,
      place: 17,
      fixed_value: true,
      total_cell: false
    },
    {
      name: 'Total Bot. Half',
      value: nil,
      top_half: false,
      place: 18,
      fixed_value: false,
      total_cell: true
    },
    {
      name: 'Total Score',
      value: nil,
      top_half: false,
      place: 19,
      fixed_value: false,
      total_cell: true
    }
  ]
  Category.create!(category_attributes)
  puts "Finished creating #{Category.count} categories..."
end
