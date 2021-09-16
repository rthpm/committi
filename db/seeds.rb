require 'faker'

User.create!(email: 'test@localhost.xyz',
            username: 'test-admin',
            password: 'undeuxtrois',
            is_admin: true)

5.times do
  User.create!(email: Faker::Internet.unique.safe_email,
              username: Faker::Internet.unique.username(separators: %w(_ -)),
              password: 'undeuxtrois')
end

# In production, you can run lib/tasks/create_categories.rb
Category.create(name: "Arts visuels", slug: "visual-arts")
Category.create(name: "Musique & audio", slug: "music-and-audio")
Category.create(name: "Vidéo", slug: "video")
Category.create(name: "Écriture", slug: "writing")
Category.create(name: "Santé", slug: "health")
Category.create(name: "Sport", slug: "sport")
Category.create(name: "Autre", slug: "misc")

10.times do
  Challenge.create!(title: Faker::Book.unique.title,
                   subtitle: Faker::Book.title,
                   description: Faker::Lorem.paragraph(sentence_count: 4),
                   user: User.all.sample,
                   category: Category.all.sample)
end

50.times do
  Status.create!(content: Faker::Lorem.paragraph(sentence_count: 4),
                 user: User.all.sample,
                 challenge: Challenge.all.sample)
end

100.times do
  Comment.create!(user: User.all.sample,
                  status: Status.all.sample,
                  content: Faker::Lorem.paragraph(sentence_count: 4))
end
