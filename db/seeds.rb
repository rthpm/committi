require 'faker'

User.create!(email: 'test@localhost.xyz',
            username: 'test_admin',
            password: '123456',
            is_admin: true,
            screen_name: 'Test Admin')

10.times do
  User.create(email: Faker::Internet.unique.safe_email,
              username: Faker::Internet.unique.username,
              password: '123456',
              screen_name: Faker::Name.name)
end
