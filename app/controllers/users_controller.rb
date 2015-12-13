class UsersController < ApplicationController

  def show
    @movies = Intentions.where(:user_id = params[:user_id])
    render "show"
  end

end
