require 'faker'
require 'json'
filepath = File.expand_path File.dirname(__FILE__) + '/plombiers.json'
serialized_beers = File.read(filepath)
plombiers = JSON.parse(serialized_beers)
puts 'recuperations du fichier plombiers.json OK'

puts 'Cleaning database...'
UserWorker.destroy_all
puts 'all userworkers destroyed'
Work.destroy_all
puts 'all works destroyed'
Worker.destroy_all
puts 'all workers destroyed'
Rent.destroy_all
puts 'all rents destroyed'
Rental.destroy_all
puts 'all rentals destroyed'
Incident.destroy_all
puts 'all incidents destroyed'
Flat.destroy_all
puts 'all flats destroyed'
User.destroy_all
puts 'all users destroyed'
puts 'all records destroyed'
puts 'Creating some of each...'
puts 'Creating workers'

photos_seed = [
"https://images.unsplash.com/photo-1446712146541-843e336d8154?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1567110823526-8ba395ecd6cc?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1569122243657-3c1c51340f65?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1517414628894-83d47b22f233?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1553104101-f1608f351b76?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1556228149-d8f523f77b5a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1554781130-e21b7c103c57?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1553444846-87cc4fe91447?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1533759413974-9e15f3b745ac?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1536858974309-969976df0d4d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1571604102350-2a203b389877?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=900&ixid=eyJhcHBfaWQiOjF9&ixlib=rb-1.2.1&q=80&w=1600",
"https://images.unsplash.com/photo-1557298294-48a457613e85?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1523772354886-34a1dc2f72e7?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1558211583-ecfebb03748b?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1556908493-4ac5f138ab77?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/flagged/photo-1556438757-f9181aa300ca?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1553444835-65ddad82cd2d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1566047913275-290b57ae311c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9",
"https://images.unsplash.com/photo-1556185781-a47769abb7ee?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9"
 ]



i = 1
plombiers.each_value do |plombier|
  # clé en STRING car provient d'un json!!
  wx = Worker.create!({
    name: plombier["name"],
    description: plombier["description"],
    address: plombier["address"],
    phone: plombier["phone"],
    email: Faker::Internet.email,
    categories: "plomberie",
  })
  puts "photo #{i}"
  wx.photos.attach(
    io: URI.open(photos_seed[i-1]),
    filename: "worker_#{i}",
    content_type: 'image/jpg',
  )
  puts "avatar #{i}"
  wx.avatar.attach(
    io: URI.open("app/assets/images/p#{i}.jpg"),
    filename: "worker_avatar_#{i}",
    content_type: 'image/jpg',
  )
  puts "Create #{i}"
  i += 1
end

puts 'Creating users...'
puts 'rock'
rock = User.create!({
  email:  "rf@gmail.com",
  password: "123456",
  first_name: "Rock",
  last_name: "FELLER",
  address: "55 rue Singer, 75016 Paris",
  phone: "06 14 14 14 14",
})
rock.avatar.attach(
  io: URI.open('https://upload.wikimedia.org/wikipedia/commons/b/b1/John_D._Rockefeller_Jr._cph.3a03736.jpg'),
  filename: "#{rock.first_name}_avatar",
  content_type: 'image/jpg',
)


puts 'alain'
alain = User.create!({
  email:  "ad@gmail.com",
  password: "123456",
  first_name: "Alain",
  last_name: "DELOIN",
  address: "33 rue du Laos",
  phone: "06 14 14 14 14",
})
alain.avatar.attach(
  io: URI.open('https://upload.wikimedia.org/wikipedia/commons/a/a9/Delon_Le_Gu%C3%A9pard_%28cropped%29.jpg'),
  filename: "#{alain.first_name}_avatar",
  content_type: 'image/jpg',
)

puts 'robert'
robert = User.create!({
  email:  "rr@gmail.com",
  password: "123456",
  first_name: "Robert",
  last_name: "Redford",
  address: "10 rue de la Paix",
  phone: "06 12 64 34 22",
})
robert.avatar.attach(
  io: URI.open('https://i.pinimg.com/originals/1c/7b/8b/1c7b8b9962619f064da9ea9fa2633bde.jpg'),
  filename: "#{robert.first_name}_avatar",
  content_type: 'image/jpg',
)


puts 'Creating flats...'
puts 'F1...'
f1 = Flat.create!({
  user_id: rock.id,
  address: "35 avenue Mac Mahon",
  zipcode: 75017,
  city: "Paris",
  description: "Très lumineux, parquet, moulure, cheminée",
  nb_rooms: 2,
  area: "64 m2",
  furnished: true,
  syndic_name: "Michau - Mme Noel",
  syndic_phone: "01 45 43 56 76",
  syndic_email: "contact@foncia.fr",
})


puts 'F2...'
f2 = Flat.create!({
  user_id: rock.id,
  address: "35 rue du Loup",
  zipcode: 33000,
  city: "Bordeaux",
  description: "Beaucoup de potentiel, orienté nord, moulure, chauffage central",
  nb_rooms: 2,
  area: "26 m2",
  furnished: true,
  syndic_name: "Foncia - Mme Durand",
  syndic_phone: "01 45 43 56 76",
  syndic_email: "contact@foncia.fr",
})


puts 'Creating incidents...'
i1 = Incident.create!({
  flat_id: f1.id,
  date: Date.new(2018,12,15),
  status: "finalisé",
  dispo: "matin tôt",
  category: "plomberie",
})

i2 = Incident.create!({
  flat_id: f1.id,
  date: Date.new(2019,06,19),
  status: "finalisé",
  dispo: "matin tôt",
  category: "plomberie",
})

i3 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2015,7,11),
  status: "finalisé",
  dispo: "matin tôt",
  category: "serrurerie",
})

i4 = Incident.create!({
  flat_id: f2.id,
  date: Date.new(2017,4,22),
  status: "finalisé",
  dispo: "soir tard",
  category: "plomberie",
})

puts 'Creating rental 1'
r1 = Rental.create!({
  user_id: alain.id,
  flat_id: f1.id,
  start_date: Date.new(2015,11,01),
  duration: 3,
  loyer: 1770,
})
puts 'photos for rental 1'
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/2/1/r/h/21rhaj90231a5il0cy0sjodlo1bud2hk6zzlzrjsw.jpg'),
  filename: "r1_2",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/0/m/j/1/0mj161xbzgrb3s1z5o2ozaeqx29i1jnrjllqwhssg.jpg'),
  filename: "r1_3",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/1/k/w/7/1kw77vndd6byxoadcngula4casrp8vzfbpx3qu3nk.jpg'),
  filename: "r1_4",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/1/b/9/8/1b98pahcjr1q55y0zp9jgsyc3nhbi437v7mgymu4g.jpg'),
  filename: "r1_5",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/2/9/d/v/29dvogjsd6puqg9vrfqhvlnurb2b52r8fubt7rvnk.jpg'),
  filename: "r1_6",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/966/visuels/1/m/s/h/1msh7k9vcmdzykab8fti2b6eyr00xwjee51w5cq2o.jpg'),
  filename: "r1_7",
  content_type: 'image/jpg',
)
r1.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/965/visuels/0/5/6/h/056hrx6qzqkd22ek06itmcu76kl08ky9jg6fu8npc.jpg'),
  filename: "r1_8",
  content_type: 'image/jpg',
)

puts "rents for rental 1"
d1 = r1.start_date
until d1 == Date.new(2019, DateTime.now().month, 01) do
  d1 += 1.month
  status = ""
  if d1 <= Date.new(2019, DateTime.now().month - 1, 01)
    status = "Payé"
  end
  Rent.create!({
    rental_id: r1.id,
    date: d1,
    status: status,
  })
end

puts 'Creating rantal 2, photos AND RENTS...'
r2 = Rental.create!({
  user_id: robert.id,
  flat_id: f2.id,
  start_date: Date.new(2018,8,01),
  duration: 3,
  loyer: 970,
})

r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/1/v/z/m/1vzmq8r0i5zzr20jx82vn8e1xzt7cn8q9ztdvexxw.jpg'),
  filename: "f1_1",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/1/b/8/x/1b8xzguqorx3bqtkgruynokk1igwg637eaopcyd04.jpg'),
  filename: "f1_2",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/1/a/u/6/1au6jsmp16igsc9zye3axsv0ru153q1dtgkkzmel0.jpg'),
  filename: "f1_3",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/0/e/6/n/0e6nsmicpooajzbzkr915lykj8l7fsc82td8v7i38.jpg'),
  filename: "f1_4",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/1/u/4/t/1u4tdemiyhva48c36sevxorcdx5pubni0lm0igytw.jpg'),
  filename: "f1_5",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/0/9/e/n/09encdazj2ifehomwr81yub3b6zco3ks6n7f51is4.jpg'),
  filename: "f1_6",
  content_type: 'image/jpg',
)
r2.photos.attach(
  io: URI.open('https://v.seloger.com/s/width/800/visuels/1/1/l/8/11l85lx2sh47gixtdhugi9kzyps25gid3aml7615g.jpg'),
  filename: "f1_7",
  content_type: 'image/jpg',
)

d2 = r2.start_date
until d2 == Date.new(2019, DateTime.now().month, 01) do
  d2 += 1.month
  status = ""
  if d2 <= Date.new(2019, DateTime.now().month - 1, 01)
    status = "Payé"
  end
  Rent.create!({
    rental_id: r2.id,
    date: d2,
    status: status,
  })
end






work1 = Worker.create!({
  name: "Ets CLAIRON",
  phone: "01 34 45 63 34",
  email: "contact@clairon.fr",
  categories: "plomberie",
})
work1.photos.attach(
    io: URI.open(photos_seed[18]),
    filename: "worker_18",
    content_type: 'image/jpg',
  )

work2 = Worker.create!({
  name: "La CLef D'OR",
  phone: "01 24 55 93 43",
  email: "patron@laclefdor.fr",
  categories: "serrurerie",
})
work2.photos.attach(
    io: URI.open('https://s3-eu-west-1.amazonaws.com/sc-files.pjms.fr/p/pjms/316/000/232/098/87244799386e4f099e804f3b6eb8dd20.jpg'),
    filename: "worker_19",
    content_type: 'image/jpg',
  )





puts 'Creating user worker relationship'
uw1 = UserWorker.create!({
  worker_id: work1.id,
  user_id:rock.id,
})

uw2 = UserWorker.create!({
  worker_id: work2.id,
  user_id:rock.id,
})

wi1 = Work.create!({
  price: 156,
  comment: "Il m'a sauvé la vie, merci beaucoup !",
  date: Date.new(2019,12,18),
  incident_id: i1.id,
  worker_id: work1.id,
})
wi2 = Work.create!({
  price: 700,
  comment: "Beau travail, merci",
  date: Date.new(2015,9,05),
  incident_id: i3.id,
  worker_id: work2.id,
})
puts 'FINISHED'
