# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#$ rails db:seed　未実行　1/25　seed1件作成のやつ
User.create!(
  email: "first@first.com",
  name: "first",
  password: "first"
  password_confirmation: "first"
)