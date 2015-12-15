class MoviesController < ApplicationController

before_action :authenticate_user!

  def index
    @movies = Movie.where(release_date: (Date.today-10..Date.today+10))
    render "index"
  end

  def show
    @movie = Movie.find(params[:id])
    intentions = Intention.where(:movie_id => params[:id])
    user_ids = []
    intentions.each do |intention|
      user_ids << intention.user_id
    end
    @users = User.where(id: user_ids, uid: current_user.friends)
    render "show"
  end

private
  def movie_params
    params.require(:movie).permit(:title, :themoviedb_id, :original_language, :overview, :release_date, :poster_path)
  end

end