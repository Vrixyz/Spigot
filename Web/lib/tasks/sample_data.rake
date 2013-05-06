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
  end
end
