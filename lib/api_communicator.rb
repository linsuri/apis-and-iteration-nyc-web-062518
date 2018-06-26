require 'rest-client'
require 'json'
require 'pry'

# get array of character's films i.e.
# ["http://swapi.co/api/films/6/",
# "http://swapi.co/api/films/3/",
# "http://swapi.co/api/films/2/",
# "http://swapi.co/api/films/1/",
# "http://swapi.co/api/films/7/"]
def get_character_films_array(character_hash, character)
  character_films_array = []
  character_hash["results"].each do |char|
    if character == char["name"]
      character_films_array = char["films"]
    end
  end
  character_films_array
end

# get array of hashes of details of films of one character i.e.
# [{"title": "Revenge of the Sith",
#	"episode_id": 3,
#	"opening_crawl": ...},
# {"title": "Attack of the Clones",
#	"episode_id": 2,
#	"opening_crawl": ...}]
def get_all_film_array(character_films_array)
  all_film_array = []
  character_films_array.each do |film|
    film_detail_ugly_hash = RestClient.get(film)
    film_detail_hash = JSON.parse(film_detail_ugly_hash)
    all_film_array << film_detail_hash
  end
  all_film_array
end

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  character_films_array = get_character_films_array(character_hash, character)
  get_all_film_array(character_films_array)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
