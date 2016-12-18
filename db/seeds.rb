<<<<<<< HEAD
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(username: "admin", password: "admin", password_confirmation: "admin", email: "admin", cellphone: "3333333333", role: "admin")
john = User.create!(username: "John Elway", password: "je", password_confirmation: "je", email: "john@example.com", cellphone: "3033033333")
taylor = User.create!(username: "Taylor Swift", password: "ts", password_confirmation: "ts", email: "ts@example.com", cellphone: "3034567891")
barack = User.create!(username: "Barack Obama", password: "bo", password_confirmation: "bo", email: "bo@example.com", cellphone: "3035284637")
donny = User.create!(username: "Donald Trump", password: "dt", password_confirmation: "dt", email: "dt@example.com", cellphone: "4639398844")
von = User.create!(username: "Von Miller", password: "vm", password_confirmation: "vm", email: "vm@example.com", cellphone: "3039362718")
albert = User.create!(username: "Albert Einstein", password: "ae", password_confirmation: "ae", email: "ae@example.com", cellphone: "4159395611")
puts "Created 1 admin and 6 users!"

admin.confirmed!
john.confirmed!
taylor.confirmed!
barack.confirmed!
donny.confirmed!
von.confirmed!
albert.confirmed!
puts "Set all statuses to confirmed!"

john.new_folder("football plays")
john.new_folder("cheerleader phone numbers")

music = taylor.new_folder("music")
songs = taylor.new_folder("songs", music)
taylor.new_folder("secret songs about boys", music)
taylor.share_folder(john, songs)

dnc_data = barack.new_folder("dnc data")
barack.new_folder("classified")
barack.share_folder(john, dnc_data)

tweets = donny.new_folder("classic tweets")
donny.share_folder(taylor, tweets)
