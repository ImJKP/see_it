class MoviesController < ApplicationController

before_action :authenticate_user!

  def index
    @movies = Movie.where(release_date: (Date.today-7..Date.today+7))
    render "index"
  end
  
  def show
    @movie = Movie.find(params[:id])
    render "show"
  end

private
  def movie_params
    params.require(:movie).permit(:title, :themoviedb_id, :original_language, :overview, :release_date, :poster_path)
  end

end