# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#$ rails db:seed 管理者User
# User.create!(
#   name: "管理者",
#   email: "admin@example.com",
#   password: "admin@example.com",
#   password_confirmation: "admin@example.com",
#   admin: true)

  # <labelデータ> 10.times →(１..10)
# (1..10).each do |i|
#   unti = '💩'*i
#   Label.create!(label_name: unti)
# end
10.times do |i|
  Label.create!(label_name: "sakamoto#{i+1}")
end