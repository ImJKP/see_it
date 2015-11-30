class Movie < ActiveRecord::Base
  has_many :users, through: :intentions


  def self.get_new_movies
    request = Typhoeus::Request.new(URI.escape("http://api.themoviedb.org/3/movie/upcoming"), method: :get, params: { api_key: "9980989d70b0f176b38dcf207cfe4a04" },headers: { Accept: "application/json" }
)
    request.run
    response = request.response.body
    response = JSON.parse(response)
    results = response["results"]
    results.each do |movie|
      unless Movie.exists?(themoviedb_id = movie["id"])
        Movie.create(title: movie["title"], themoviedb_id: movie["id"], original_language: movie["original_language"], overview: movie["overview"], poster_path: movie["poster_path"], release_date: movie["release_date"])
      end
    end
  end
  
end
