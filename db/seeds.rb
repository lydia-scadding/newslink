# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
User.destroy_all

puts "Creating users..."
ruby = User.create!(username: "rubyfan", password: "password")
tim = User.create!(username: "timcook", password: "password")
js = User.create!(username: "jsFiend", password: "password")

puts "Creating links..."
ruby.links.create!(title: "Ruby docs", url: "https://ruby-doc.org", description: "All the Ruby methods")
tim.links.create!(title: "Official Apple UK Site", url: "https://www.apple.com/uk/", description: "my personal website")
js.links.create!(title: "Javascript blog", url: "https://davidwalsh.name/", description: "loads of cool stuff about JavaScript")

puts "Created #{User.count} users and #{Link.count} links"
