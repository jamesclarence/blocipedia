require 'faker'

# Create Users
20.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8)
  )
  user.skip_confirmation!
  user.save!
end

# Create Wikis
50.times do
   Wiki.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 Wikis = Wiki.all

# Create a standard member
standard = User.new(
    name:       'Standard User',
    email:      'standard@example.com',
    password:   'helloworld',
    role:       'standard'
)
standard.skip_confirmation!
standard.save!

# Create a premium member
premium = User.new(
    name:       'Premium User',
    email:      'premium@example.com',
    password:   'helloworld',
    role:       'premium'
)
premium.skip_confirmation!
premium.save!

# Create an admin
admin = User.new(
    name:       'Admin User',
    email:      'admin@example.com',
    password:   'helloworld',
    role:       'admin'
)
admin.skip_confirmation!
admin.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
