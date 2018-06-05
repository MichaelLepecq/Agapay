# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#

NAMES_OF_MALFORMED_CHARITIES = [
  "Indo-Canadian Friendship Society of British Columbia (ICFSBC)",
  "EARTH DAY CANADA"
]

require 'json'
require 'open-uri'
require 'nokogiri'

puts "Destroying old data..."

Picture.destroy_all
CharityCategory.destroy_all
UserCharity.destroy_all
Charity.destroy_all
Category.destroy_all
User.destroy_all



# Seed users

joy = User.create!(
  first_name: "Joy",
  last_name: "Navi",
  # remote_photo_url: "",
  email: "joy@joy.com",
  password: "123456",
)

mg = User.create!(
  first_name: "mg",
  last_name: "ayoub",
  # remote_photo_url: "",
  email: "mg@mg.com",
  password: "123456"
)

michael = User.create!(
  first_name: "michael",
  last_name: "lepecq",
  # remote_photo_url: "",
  email: "mike@mike.com",
  password: "123456",
)

gaelle = User.create!(
  first_name: "gaelle",
  last_name: "londoz",
  # remote_photo_url: "",
  email: "gaelle@gaelle.com",
  password: "123456",
)

puts "creating categories"
categories = ["animals", "international", "arts-culture", "indigenous-peoples", "environment", "social-services", "health", "education", "public-benefit", "religion"]
categories.each do |cat|
  Category.create!(name: cat)
  puts "created category #{cat}"
end

puts "-------------"

puts "Creating seeds from canadahelps.org..."
i = 0
until i == 140 do
  doc = open("https://www.canadahelps.org/fr/search/charities/?category=environment&offset=#{i}").read
  file = JSON.parse(doc)
  j = 0
  20.times do

    if file['results'][j]['charity_profile']['new_hero_image_en'] != nil

      picture_urls = []
      img_path = file['results'][j]['urls']['charity_profile']
      url = "https://www.canadahelps.org#{img_path}"
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)

      html_doc.search('*[href="#main-ch-modal"]').each do |el|
        pic_url = el['data-modal-content'].gsub(/\"/, "").split(",")[0].gsub(/\{\simage_url:\s/, "").gsub(/\{video_url:\/\//, "")
        unless pic_url.empty?
          picture_urls << pic_url
        end
      end

      unless picture_urls == [] || NAMES_OF_MALFORMED_CHARITIES.include?(file['results'][j]['popular_name_en'])
        charity = Charity.new({
          name: file['results'][j]['popular_name_en'],
          city: file['results'][j]['city'],
          province: file['results'][j]['province'],
          business_number: file['results'][j]['business_number'],
          description: file['results'][j]['charity_profile']['about_en'],
          logo: "https://www.canadahelps.org#{file['results'][j]['charity_profile']['logo']}"
        })
        puts "created charity #{charity.name}"
        file['results'][j]['categories'].each do |cate|
          CharityCategory.create!(charity: charity, category: Category.find_by(name: cate))
          puts "added category #{cate} to #{charity.name}"
        end
        picture_urls.each do |picture_url|
          Picture.create!(image_url: picture_url, charity_id: charity.id)
        end

      end


      puts j
      j += 1
    else
      j += 1
    end
  end
  puts "---------------"
  i += 20

end
puts "Finished"
