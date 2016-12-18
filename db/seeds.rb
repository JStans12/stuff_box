john = User.create!(username: "John Elway", password: "je", password_confirmation: "je", email: "john@example.com", cellphone: "3033033333")
taylor = User.create!(username: "Taylor Swift", password: "ts", password_confirmation: "ts", email: "ts@example.com", cellphone: "3034567891")
barack = User.create!(username: "Barack Obama", password: "bo", password_confirmation: "bo", email: "bo@example.com", cellphone: "3035284637")
donny = User.create!(username: "Donald Trump", password: "dt", password_confirmation: "dt", email: "dt@example.com", cellphone: "4639398844")
von = User.create!(username: "Von Miller", password: "vm", password_confirmation: "vm", email: "vm@example.com", cellphone: "3039362718")
albert = User.create!(username: "Albert Einstein", password: "ae", password_confirmation: "ae", email: "ae@example.com", cellphone: "4159395611")

john.confirmed!
taylor.confirmed!

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
