require 'yaml'
require_relative 'scraper'
# 1. Scrape all urls
urls = fetch_movies_urls
puts "Scraped 5 urls"
# 2. scrape each one of the movies
# MAP ITERATOR
movies = urls.map do |url|
  scrape_movie(url)
end
puts "Scraped movies"
# 3. dump the information into a YAML file
File.open('movies.yml', 'wb') do |file|
  file.write(movies.to_yaml)
end
puts "Done zo/"
