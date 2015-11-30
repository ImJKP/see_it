class IntentionsController < ApplicationController

  def create 
    unless Intention.exists?(user_id: current_user, movie_id: params[:movie_id])
      Intention.create(user_id: current_user, movie_id: params[:movie_id]
    end
  end
  
  def destroy
    if Intention.exists?(user_id: current_user, movie_id: params[:movie_id])
      Intention.where(user_id: current_user, movie_id: params[:movie_id]).delete
    end
  end

private

  def intention_params
    params.require(:intention).permit(:user_id, :movie_id)
  end

end
