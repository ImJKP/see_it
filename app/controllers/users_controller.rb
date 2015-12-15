class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    my_intentions = Intention.where(:user_id => params[:id])
    movie_ids = []
    my_intentions.each do |intention|
      movie_ids << intention[:movie_id]
    end
    @movies = Movie.where(release_date: (Date.today-10..Date.today+10), id: movie_ids)
    render "show"
  end

before_action :authenticate_user!

  def friends
    @friends = User.where(uid: current_user.friends)
    render "friends"
  end

end
