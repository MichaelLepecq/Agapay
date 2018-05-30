# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
require 'json'
require 'open-uri'

puts "Destroying old data..."
Charity.destroy_all
Category.destroy_all

# Seed users

joy = User.create!(
  first_name: "Joy",
  last_name: "Navi",
  remote_photo_url: "",
  email: "joy@joy.com",
  password: "123456",
)

mg = User.create!(
  first_name: "mg",
  last_name: "ayoub",
  remote_photo_url: "",
  email: "mg@mg.com",
  password: "123456"
)

michael = User.create!(
  first_name: "michael",
  last_name: "lepecq",
  remote_photo_url: "",
  email: "mike@mike.com",
  password: "123456",
)

gaelle = User.create!(
  first_name: "gaelle",
  last_name: "londoz",
  remote_photo_url: "",
  email: "gaelle@gaelle.com",
  password: "123456",
)

categories = ["animal", "international", "art", "indigenous", "environment", "social", "health", "education"]
categories.each do |cat|
  Category.create!(name: cat)
end

doc = open('https://www.canadahelps.org/fr/search/charities/?category=environment&offset=20').read
file = JSON.parse(doc)

puts "Creating seeds from canadahelps.org..."
i = 0
19.times do
  Charity.create!({
    name: file['results'][i]['popular_name_en'],
    city: file['results'][i]['city'],
    province: file['results'][i]['province'],
    business_number: file['results'][i]['business_number'],
    description: file['results'][i]['charity_profile']['about_en'],
    logo: "https://www.canadahelps.org#{file['results'][i]['charity_profile']['logo']}"
  })
  i += 1
end
puts "Finished"
