# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(username: "admin", password: "admin", password_confirmation: "admin", email: "admin", cellphone: "3333333333", role: "admin")
user1 = User.create!(username: "John Elway", password: "je", password_confirmation: "je", email: "john@example.com", cellphone: "3033033333")
user2 = User.create!(username: "Taylor Swift", password: "ts", password_confirmation: "ts", email: "ts@example.com", cellphone: "3034567891")
user3 = User.create!(username: "Barack Obama", password: "bo", password_confirmation: "bo", email: "bo@example.com", cellphone: "3035284637")
user4 = User.create!(username: "Donald Trump", password: "dt", password_confirmation: "dt", email: "dt@example.com", cellphone: "4639398844")
user5 = User.create!(username: "Von Miller", password: "vm", password_confirmation: "vm", email: "vm@example.com", cellphone: "3039362718")
user6 = User.create!(username: "Albert Einstein", password: "ae", password_confirmation: "ae", email: "ae@example.com", cellphone: "4159395611")


user1.new_folder("Music")
user1.new_folder("Work Files")
user1.new_folder("Personal")
user2.new_folder("Music")
user2.new_folder("Vacation Research")
user3.new_folder("Music")
user4.new_folder("Music")
user4.new_folder("Work Stuff")
user4.new_folder("Sports")
user5.new_folder("Music")
user5.new_folder("Artwork")
user6.new_folder("Music")
user6.new_folder("Work Files")
user6.new_folder("Inventions")
