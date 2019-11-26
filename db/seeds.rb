# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
# Workers.destroy_all
# puts 'all workers destroyed'
# Rents.destroy_all
# puts 'all rents destroyed'
# Works.destroy_all
# puts 'all works destroyed'
# UserWorkers.destroy_all
# puts 'all userworkers destroyed'
# Rentals.destroy_all
# puts 'all rentals destroyed'
Incident.destroy_all
puts 'all incidents destroyed'
Flat.destroy_all
puts 'all flats destroyed'
User.destroy_all
puts 'all users destroyed'

puts 'all records destroyed'
puts 'Creating some of each...'

puts 'Creating users...'
rock = User.create!({
  email:  "rf@gmail.com",
  password: "123456",
  first_name: "Rock",
  last_name: "FELLER",
  address: "55 rue Singer, 75016 Paris",
  phone: "06 14 14 14 14",
})

alain = User.create!({
  email:  "ad@gmail.com",
  password: "123456",
  first_name: "Alain",
  last_name: "DELOIN",
  address: "33 rue du Laos",
  phone: "06 14 14 14 14",
})

robert = User.create!({
  email:  "rr@gmail.com",
  password: "123456",
  first_name: "Robert",
  last_name: "Redford",
  address: "10 rue de la Paix",
  phone: "06 12 64 34 22",
})

puts 'Creating flats...'
f1 = Flat.create!({
  user_id: rock.id,
  address: "35 avenue Mac Mahon",
  description: "Très lumineux, parquer, moulure, cheminée",
  nb_rooms: 2,
  area: "64 m2",
  furnished: false,
  syndic_name: "Michau - Mme Noel",
  syndic_phone: "01 45 43 56 76",
  syndic_email: "contact@foncia.fr",
})

f2 = Flat.create!({
  user_id: rock.id,
  address: "35 rue du Loup",
  description: "Beaucoup de potentiel, orienté nord, moulure, chauffage central",
  nb_rooms: 2,
  area: "26 m2",
  furnished: false,
  syndic_name: "Foncia - Mme Durand",
  syndic_phone: "01 45 43 56 76",
  syndic_email: "contact@foncia.fr",
})

puts 'Creating incidents...'
i1 = Incident.create!({
  flat_id: f1.id,
  date: Date.new(2019,12,15),
  status: "finalisé",
  dispo: "matin tôt",
  # type: "fuite",
})

i2 = Incident.create!({
  flat_id: f1.id,
  date: Date.new(2019,12,15),
  status: "finalisé",
  dispo: "matin tôt",
  # type: "fuite",
})

i3 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2015,7,11),
  status: "finalisé",
  dispo: "matin tôt",
  # type: "fuite",
})

i4 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2017,4,22),
  status: "finalisé",
  dispo: "soir tard",
  # type: "fuite",
})

puts 'Creating rantal 1 AND RENTS...'
r1 = Rental.create!({
  user_id: alain.id,
  flat_id: f1.id,
  start_date: Date.new(2015,11,01),
  duration: 3,
  rent: 1770,
})
d1 = r1.start_date
until d1 = Date.new(2019, DateTime.now().month - 1, 01) do
  d1 += 1.month
  Rent.create!({
    rental_id: r1.id,
    date: d1
  })
end

puts 'Creating rantal 2 AND RENTS...'
r2 = Rental.create!({
  user_id: robert.id,
  flat_id: f2.id,
  start_date: Date.new(2018,8,01),
  duration: 3,
  rent: 970,
})
d2 = r2.start_date
until d2 = Date.new(2019, DateTime.now().month - 1, 01) do
  d1 += 1.month
  Rent.create!({
    rental_id: r2.id,
    date: d2
  })
end

puts 'Creating workers'
w1 = Worker.new({
  name: "Ets CLAIRON",
  pone: "01 34 45 63 34",
  email: "contact@clairon.fr",
  categories: "plomberie, électricité",
})
w2 = Worker.new({
  name: "La CLef D'OR",
  pone: "01 24 55 93 43",
  email: "patron@laclefdor.fr",
  categories: "serrurerie",
})

puts 'Creating user worker relationship'
uw1= UserWorker.new({
  worker_id: w1.id,
  user_id:rock.id,
})

uw2= UserWorker.new({
  worker_id: w2.id,
  user_id:rock.id,
})



# tonton = User.create!({
#   email:  "ad@gmail.com",
#   password: "123456",
#   first_name: "Alain",
#   last_name: "DELOIN"
# })
# tata = User.create!({
#   email:  "tata@gmail.com",
#   password: "123456",
#   first_name: "Claudine",
#   last_name: "Georgette"
# })
# tutu = User.create!({
#   email:  "tutu@gmail.com",
#   password: "123456",
#   first_name: "Maurice",
#   last_name: "Latutule"
# })
# titi = User.create!({
#   email:  "titi@gmail.com",
#   password: "123456",
#   first_name: "Thierry",
#   last_name: "Henry"
# })

# puts 'Creating fake products...'
# p1 = Product.create!({
#   category: "kite",
#   brand: "2020 Cabrinha Crosswing",
#   description: "Designed for riders looking for an efficient power source to use with many types of watercraft, the all-new Crosswing is the simplest form of wind driven power you can hold in your own two hands. The Crosswing is a compact, fully controllable inﬂatable wing with an incredibly wide range of use on water or land.
# Its simplicity is unmatched. The Crosswing is free of control lines, there is no mast, no separate boom or a control bar. Everything you need to ﬂy the wing is contained in its fully integrated form. Once you inﬂate the wing (in 20 seconds or less), it is ready to ﬂy.
# The Crosswing is instantly compatible with many boards currently in use, from foil boards to SUPs to snowboards or skateboards, making it the perfect tool to ﬂy yourself across any body of water or land. ",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: toto.id,
#   address: "157 Rue du Po, 56340 Carnac"
# })

# puts 'product 1'

# p2 = Product.create!({

#   category: "board",
#   brand: "Duotone",
#   description: "Trying to get into the world of hydrofoil surfing?  Not sure what you need to get? With so many options out there and more arriving every single day, it is no wonder you may be a bit confused or gun shy.  The FS1 is Liquid Force’s solution to your problem. ",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: toto.id,
#   address: "2 Rue Florian Laporte, 56100 Lorient"
# })
# puts 'product 2'

# p3 = Product.create!({
#   category: "harness",
#   brand: "2020 Duotone Apex Curve 13 Select",
#   description: "DUOTONE APEX CURVE 13 SELECT
# The Duotone Apex Curv 13 Select in cooperation with ION is a very light and one of the most durable hardshell harnesses on the market featuring ION's revolutionary thermo composite CURV material. Thanks to high-end add-ons like the C_Bar 3.0 (Hook/Webbing Slider), Double D Buckles and Kite_Knife Multitool 2.0, the Select level stands out from the crowd. With a flex index of 13, all loads are distributed perfectly through its rigid 3D pre-shaped center part. Together with the high outline, this medium rigid to stiff hardshell harness offers all the comfort any dedicated kiter could wish for. Flexible side parts allow the rider to move and twist freely. Additionally, inside EVA prevents the harness from riding up while non-water absorbent Hyper_foam contributes to outstanding comfort for extra-long water action.",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: titi.id,
#   address: "District de Sants-Montjuïc, Barcelone, Espagne"
# })
# puts 'product 3'

# p4 = Product.create!({
#   category: "kite bar",
#   brand: "2020 Liquid Force Direct Drive Control System",
#   description: "In collaboration with R3 Design, Liquid Force is proud to introduce the Direct Drive control bar. On-the-fly trimming of the kite has never been easier with the bar mounted Sidewinder control knob. This intuitive system adjusts the kite’s power by trimming the rear lines of the kite. ",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: tonton.id,
#   address: "1-5 Avenue du Golf, 33120 Arcachon"
# })
# puts 'product 4'

# Product.create!({
#   category: "full kite",
#   brand: "surfbrand",
#   description: "This set contains of:
# - 1x Mono in size of choice
# - 1x Trust Bar Quad Control 24m
# - 1x Quick Release Freeride Kit
# - 1x Quest TT
# The product details were shown here on you-love-it on each single detail site of our articles",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: tonton.id,
#   address: "154-340 Avenue du Onze Novembre, 40600 Biscarrosse"
# })
# puts 'product 5'

# Product.create!({
#   category: "accessories",
#   brand: "2020 ION Neo Zip Top Men LS 2/1 CSK",
#   description: "NEO TOPS are a must-have for every watersports nut hitting the sea or surf in milder climates. Although mainly used in warmer waters to keep the sun and wind off the skin, they can also be used as a second layer underneath your wetsuit. Thanks to the plush, wool-like Hot_Stuff lining, these tops have a luxurious texture that feels great, even on bare skin!
# The NEO TOPS have a more detailed and technical construction than that of the standard Rashguard, providing 100% UV protection, efficient heat retention and a reduction in irritations and bruising often caused by the harness or surfboard.",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: tata.id,
#   address: "Midoun, Tunisie"
# })
# puts 'product 6'

# Product.create!({
#   category: "full kite",
#   brand: "surfbrand",
#   description: "Lorem efef ezf eez ",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: tata.id,
#   address: "Erriadh Tunisie"
# })
# puts 'product 7'

# Product.create!({
#   category: "board",
#   brand: "Duotone",
#   description: "Lorem efef ezf eez ",
#   status: STATUS[rand(0..4)],
#   price: rand(50..150),
#   user_id: tutu.id,
#   address: "9 Rue des Falaises, 66290 Cerbère"
# })
# puts 'product 8'

# Rental.create!({
#   user_id: titi.id,
#   product_id: p1.id,
#   date_start: Date.new(2019,12,24),
#   date_end: Date.new(2020,12,25),
# })

# Rental.create!({
#   user_id: titi.id,
#   product_id: p2.id,
#   date_start: Date.new(2019,12,21),
#   date_end: Date.new(2020,11,21),
# })

# Rental.create!({
#   user_id: toto.id,
#   product_id: p3.id,
#   date_start: Date.new(2020,1,1),
#   date_end: Date.new(2020,2,1),
# })

# Rental.create!({
#   user_id: toto.id,
#   product_id: p4.id,
#   date_start: Date.new(2019,12,18),
#   date_end: Date.new(2019,12,19),
# })

# Rental.create!({
#   user_id: toto.id,
#   product_id: p4.id,
#   date_start: Date.new(2020,11,21),
#   date_end: Date.new(2020,11,21),
# })
# puts 'Finished!'
