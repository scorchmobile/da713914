# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Admin.create email: 'kim@conversationpeople.com', first_name: 'Kim', last_name: 'Jaggard', password: 'D3putiZe!!'
#TempDatum.create first_name: 'Filler', last_name: 'Filler', email: 'a@a.com', phone: '111222333', member_type: 'filler'

Page.create title: 'Homepage', visible: true, private: false, permalink: 'homepage'

Fact.create [{headline: 'TTT', line_one: 'TTT', line_two: 'TTT'}, {headline: 'TTT', line_one: 'TTT', line_two: 'TTT'}, {headline: 'TTT', line_one: 'TTT', line_two: 'TTT'}]
