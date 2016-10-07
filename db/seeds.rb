require 'faker'

# <<# USERS #>>

# Create a Admin User
admin_user = User.create!(
    username: 'adminuser',
    email: 'auser@bloc.io',
    password: 'AAbb11',
    password_confirmation: 'AAbb11',
    role: 'admin'
)
# admin_user.skip_confirmation!
admin_user.save!

# Create a Premium User
premium_user = User.create!(
    username: 'premiunuser',
    email: 'puser@bloc.io',
    password: 'AAbb11',
    password_confirmation: 'AAbb11',
    role: 'premium'
)
# premium_user.skip_confirmation!
premium_user.save!


# Create a Standard User
standard_user = User.create!(
    username: 'standarduser',
    email: 'suser@bloc.io',
    password: 'AAbb11',
    password_confirmation: 'AAbb11',
    role: 'standard'
)
# standard_user.skip_confirmation!
standard_user.save!

users = User.all

# <<# WIKIS #>>

15.times do
  Wiki.create!(
      user: users.sample,
      title: Faker::Name.title,
      body: Faker::Hipster.paragraph,
      private: Faker::Boolean.boolean
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"