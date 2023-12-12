require 'open-uri'
require 'nokogiri'

# One scraper for the top five url
# return an array with 5 urls
def fetch_movies_urls
  # 1. Make an HTTP reqeust to the url
  html_file = URI.open("https://www.imdb.com/chart/top/", {
    'User-Agent' => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0"
  }).read
  # 2. Parse the html response using nokogiri
  html_doc = Nokogiri::HTML.parse(html_file)
  # 3. We need to inspect the browser and find a way to scrape the right element
  # 4. Use nokogiri method #search(CSS_SELECTOR) to find the elements
  movie_urls = []
  html_doc.search(".ipc-title.ipc-title--base.ipc-title--title.ipc-title-link-no-icon.ipc-title--on-textPrimary.sc-43986a27-9.gaoUku.cli-title a").first(5).each do |element|
    url = element.attribute('href').value
    # movie_url = url.match(/(.+)\?/)[1]
    # movie_urls << "https://www.imdb.com#{movie_url}"
    movie_url = URI.parse(url)
    movie_url.scheme = 'https'
    movie_url.host = "www.imdb.com"
    movie_url.query = nil
    movie_urls << movie_url.to_s
  end
  movie_urls
end

# One scraper to an specific url
def scrape_movie(movie_url)
  # 1. Make an HTTP reqeust to the url
  html_file = URI.open(movie_url, {
    'User-Agent' => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0",
    'Accept-Language' => "en-US"
  }).read
  # 2. Parse the html response using nokogiri
  html_doc = Nokogiri::HTML.parse(html_file)
  # 3. We need to inspect the browser and find a way to scrape the right element
  # 4. Use nokogiri method #search(CSS_SELECTOR) to find the elements
  director_name = html_doc.search('.ipc-metadata-list__item:contains("Director") a').last.text
  stars_array = []
  html_doc.search('.ipc-metadata-list__item:contains("Stars") .ipc-metadata-list-item__content-container a').first(3).each do |element|
    stars_array << element.text.strip
  end
  storyline = html_doc.search('.sc-466bb6c-2.chnFO').first.text.strip
  year = html_doc.search('.ipc-inline-list.ipc-inline-list--show-dividers.sc-d8941411-2.cdJsTz.baseAlt a').first.text.strip.to_i
  title = html_doc.search('h1').first.text.strip

  {
    director: director_name,
    cast: stars_array,
    storyline: storyline,
    year: year,
    title: title
  }
end
