namespace :db do
  task :create_admin, [:name, :email, :password] => :environment do |t, args|
    puts "args: '#{args}'"
    admin = User.create!(name: args[:name],
                         email: args[:email],
                         password: args[:password],
                         password_confirmation: args[:password])
    admin.toggle!(:admin)
  end
end
