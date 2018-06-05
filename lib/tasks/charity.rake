namespace :charity do
  desc "store data from canada helps api"
  task api: :environment do
    pages_of_json_results = []

    json = JSON.parse(open("https://www.canadahelps.org/fr/search/charities/").read)
    pages_of_json_results << json
    next_url = json["next"]

    100.times do
      json = JSON.parse(open(next_url).read)

      json["results"].each_with_index do |result|
        result["picture_urls"] = []

        img_path = result['urls']['charity_profile']

        url = "https://www.canadahelps.org#{img_path}"
        html_file = open(url).read
        html_doc = Nokogiri::HTML(html_file)

        html_doc.search('*[href="#main-ch-modal"]').each do |el|
          pic_url = el['data-modal-content'].gsub(/\"/, "").split(",")[0].gsub(/\{\simage_url:\s/, "").gsub(/\{video_url:\/\//, "")
          unless pic_url.empty?
            result["picture_urls"] << pic_url
          end
        end
      end

      pages_of_json_results << json
      next_url = json["next"]
    end

    File.open(Rails.root.join("db") + "charity_api_results.json", "w") do |file|
     file.write(JSON.pretty_generate(pages_of_json_results))
    end
  end
end
