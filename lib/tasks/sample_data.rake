namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "admin",
                         email: "example@railstutorial.org",
                         password: "admin42",
                         password_confirmation: "admin42")
    admin.toggle!(:admin)


    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!( name:name,
                    email:email,
                    password:password,
                    password_confirmation:password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(100)
      title = Faker::Lorem.sentence(5)
      users.each { |user| user.posts.create!(content: content, title: title) }
    end
  end
end
