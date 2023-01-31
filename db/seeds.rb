# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#$ rails db:seed 管理者User
User.create!(
  name: "管理者",
  email: "admin@example.com",
  password: "admin@example.com",
  password_confirmation: "admin@example.com",
  admin: true)

  # <labelデータ> 10.times →(１..10)  ラベルの順番の都合上10.times メソッドに変更＿使用しない
# (1..10).each do |i|
#   unti = '💩'*i
#   Label.create!(label_name: unti)
# end
tasks = Task.all
tasks = tasks.map{|task| task.id}
labels = Label.all
labels = labels.map{|label| label.id}


10.times do |i|
  Label.create!(label_name: "sakamoto#{i+1}")
end

start_day = DateTime.new(1995, 2, 24, 12, 30, 45)
last_day = DateTime.new(2023, 1, 31, 12, 30, 30)

users = User.all
users = users.map{|user| user.id}


# <taskデータ>
10.times do |i|
  Task.create!(
    title: "タスク#{i + 1}",
    content: "タスクつくったよ！",
    expired_at: rand(start_day..last_day),
    priority: rand(0..2),
    status: rand(0..2),
    user_id: users.sample)
  end


# <userデータ>
User.create(name: 'sa1', email: 'sa1@gmail.com', password: 'sa1@gmail.com', password_confirmation: 'sa1@gmail.com')
User.create(name: 'sa2', email: 'sa2@gmail.com', password: 'sa2@gmail.com', password_confirmation: 'sa2@gmail.com')
User.create(name: 'sa3', email: 'sa3@gmail.com', password: 'sa3@gmail.com', password_confirmation: 'sa3@gmail.com')
User.create(name: 'sa4', email: 'sa4@gmail.com', password: 'sa4@gmail.com', password_confirmation: 'sa4@gmail.com')
User.create(name: 'sa5', email: 'sa5@gmail.com', password: 'sa5@gmail.com', password_confirmation: 'sa5@gmail.com')
User.create(name: 'sa6', email: 'sa6@gmail.com', password: 'sa6@gmail.com', password_confirmation: 'sa6@gmail.com')
User.create(name: 'sa7', email: 'sa7@gmail.com', password: 'sa7@gmail.com', password_confirmation: 'sa7@gmail.com')
User.create(name: 'sa8', email: 'sa8@gmail.com', password: 'sa8@gmail.com', password_confirmation: 'sa8@gmail.com')
User.create(name: 'sa9', email: 'sa9@gmail.com', password: 'sa9@gmail.com', password_confirmation: 'sa9@gmail.com')
User.create(name: 'sa10', email: 'sa10@gmail.com', password: 'sa10@gmail.com', password_confirmation: 'sa10@gmail.com')

