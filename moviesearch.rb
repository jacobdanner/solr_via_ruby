require 'rsolr'
class Movie
  attr_accessor :id, :title, :actors, :summary
  def initialize()
    @actors = []
  end
end

class Indexer
  def initialize
    @solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'
  end

  def index(movies)
    movies.each do |movie|
    @solr.add :id=>movie.id.to_s, :title=>movie.title, :actor =>movie.actors
    end
    @solr.update :data => '<commit/>'
  end
end

class Searcher
  def initialize
    @solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'
  end

  def search(term)
    term = term.downcase
    response = @solr.get 'select', :params => { :q => "title:#{term}* or actor:#{term}*"}
    list = response["response"]["docs"]
    list
  end
end


# Test the above classes via script
movie_1 = Movie.new
movie_1.actors << 'Bruce Willis'
movie_1.actors << "Samuel Jackson"
movie_1.id = '1'
movie_1.title='Die Hard 3'
movie_2 = Movie.new
movie_2.actors << 'Mel Gibson'
movie_2.actors << 'Danny Glover'
movie_2.id = '2'
movie_2.title = 'Lethal Weapon'
movie_1.summary = "Great movie"
movie_2.summary = 'Another great movie'

#Indexing
idxr=Indexer.new
idxr.index [movie_1,movie_2]

#Searching
searcher = Searcher.new
searcher.search 'Die'
searcher.search 'Bru'
searcher.search 'Glo'




