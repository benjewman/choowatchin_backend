# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do 
    Show.create(medium: 'movie', title: Faker::Book.title, year: '1999', imdbID: 'tt8946378')
end

5.times do
    Show.create(medium: 'series', title: Faker::Book.title, year: '1999', imdbID: 'tt8946378')
end

5.times do
    User.create(username: Faker::Beer.brand, full_name: Faker::Beer.name, email: Faker::Kpop.boy_bands)
end

5.times do
    Review.create(stamp: 'Noice', user_id: 1 + rand(5), show_id: 1 + rand(10), content: Faker::Lorem.sentence(word_count: 5))
end