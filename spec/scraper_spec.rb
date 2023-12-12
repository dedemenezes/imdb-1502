require_relative '../scraper'

# describe "#fetch_movies_urls" do
#   it 'returns an array with 5 urls' do
#     # we write the test
#     expected_array = [
#       "https://www.imdb.com/title/tt0111161/",
#       "https://www.imdb.com/title/tt0068646/",
#       "https://www.imdb.com/title/tt0468569/",
#       "https://www.imdb.com/title/tt0071562/",
#       "https://www.imdb.com/title/tt0050083/"
#     ]
#     expect(fetch_movies_urls).to eq(expected_array)
#   end
# end

describe "#scrape_movie" do
  it "returns a Hash describing a movie" do
    the_dark_knight_url = "https://www.imdb.com/title/tt0468569/"
    movie = scrape_movie(the_dark_knight_url)

    expected = {
      cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
      director: "Christopher Nolan",
      storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      title: "The Dark Knight",
      year: 2008
    }
    expect(movie).to eq(expected)
  end
end
