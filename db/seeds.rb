# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Workers.destroy_all
puts 'all workers destroyed'
Rents.destroy_all
puts 'all rents destroyed'
Works.destroy_all
puts 'all works destroyed'
UserWorkers.destroy_all
puts 'all userworkers destroyed'
Rentals.destroy_all
puts 'all rentals destroyed'
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
  types: "plomberie",
})

i2 = Incident.create!({
  flat_id: f1.id,
  date: Date.new(2019,12,15),
  status: "finalisé",
  dispo: "matin tôt",
  types: "plomberie",
})

i3 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2015,7,11),
  status: "finalisé",
  dispo: "matin tôt",
  types: "serrurerie",
})

i4 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2017,4,22),
  status: "finalisé",
  dispo: "soir tard",
  types: "plomberie",
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

wi1 Work.new({
  price: 156,
  comment: "Il m'a sauvé la vie, merci beaucoup !",
  date: Date.new(2019,12,18),
  incident_id: i1.id,
  worker_id: w1.id,
})
wi2 Work.new({
  price: 700,
  comment: "Beau travail, merci",
  date: Date.new(2015,9,05),
  incident_id: i3.id,
  worker_id: w2.id,
})
