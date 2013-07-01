namespace :db do
  task :create_admin, [:email, :password] => :environment do |t, args|
    puts "args: '#{args}'"
    admin = User.create!(name: "TheAdmin",
                         email: args[:email],
                         password: args[:password],
                         password_confirmation: args[:password])
    admin.toggle!(:admin)
  end
end
