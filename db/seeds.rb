require 'faker'

User.create!(email: 'test@localhost.xyz',
            username: 'test-admin',
            password: 'undeuxtrois',
            is_admin: true,
            screen_name: 'Test Admin')

5.times do
  User.create!(email: Faker::Internet.unique.safe_email,
              username: Faker::Internet.unique.username(separators: %w(_ -)),
              password: 'undeuxtrois',
              screen_name: Faker::Name.name)
end

4.times do
  Challenge.create!(title: Faker::Book.title,
                   subtitle: Faker::Book.title,
                   description: Faker::Lorem.paragraph(sentence_count: 4),
                   user: User.all.sample)
end

10.times do
  Status.create!(content: Faker::Lorem.paragraph(sentence_count: 4),
                 user: User.all.sample,
                 challenge: Challenge.all.sample)
end

100.times do
  Like.create!(user: User.all.sample,
               status: Status.all.sample)
end

50.times do
  Comment.create!(user: User.all.sample,
                  status: Status.all.sample,
                  content: Faker::Lorem.paragraph(sentence_count: 4))
end
