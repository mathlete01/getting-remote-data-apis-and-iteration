require 'rest-client'
require 'json'
require 'pry'
require 'pp'

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.

def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)
  all_characters = response_hash["results"]
  i = 0
  while i < all_characters.length 
    if all_characters[i]["name"] == character_name
      film_array = all_characters[i]["films"]
    end
    i += 1
  end
  j = 0
  titles = []
  while j < film_array.length do
    movie_hash_raw = RestClient.get(film_array[j])
    movie_hash_json = JSON.parse(movie_hash_raw)
    title = movie_hash_json["title"]
    titles << title
    j += 1
  end
  return titles
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  pp films
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
