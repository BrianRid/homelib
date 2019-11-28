require 'open-uri'
require 'nokogiri'
require 'json'
# scrapping pages jaunes
url = 'https://www.pagesjaunes.fr/annuaire/paris-75/plombiers'

html_file = open(url, "User-Agent" => "Whatever you want here").read
html_doc = Nokogiri::HTML(html_file)

workers = {}

html_doc.search('.bi-bloc header a.denomination-links').first(20).each_with_index do |element, i|
  i = "worker_#{(i + 1)}".to_sym
  workers[i] = { name: element.text.strip }
end

html_doc.search('.bi-bloc header a.adresse').first(20).each_with_index do |element, i|
  i = "worker_#{(i + 1)}".to_sym
  workers[i][:address] = element.text.strip
end

html_doc.search('div.description div.zone-cvi-cviv p:first-child').first(20).each_with_index do |element, i|
  i = "worker_#{(i + 1)}".to_sym
  description = element.text.strip

  pattern = /(?<title>.*)\n(?<content>.*)/

  match_data = description.match(pattern)
  workers[i][:description] = match_data[:content]
end

html_doc.search('.bi-bloc strong.num').first(20).each_with_index do |element, i|
  i = "worker_#{(i + 1)}".to_sym
  workers[i][:phone] = element.text.strip
end

File.open('db/plombiers.json', 'wb') do |file|
  file.write(JSON.generate(workers))
end
