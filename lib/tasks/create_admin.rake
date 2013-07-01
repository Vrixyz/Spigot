task :create_admin, :email, :password do |t, args|
  admin = User.create!(name: "admin",
                       email: :email,
                       password: :password,
                       password_confirmation: :password)
  admin.toggle!(:admin)
end
