class IntentionsController < ApplicationController

  def create
    intention = Intention.where(:user_id => params[:user_id], :movie_id => params[:movie_id])
    unless intention.exists?
      Intention.create(:user_id => params[:user_id], :movie_id => params[:movie_id])
    end
    redirect_to movie_path(params[:movie_id])
  end

  def destroy
    intention = Intention.where(user_id: params[:user_id], movie_id: params[:movie_id]).first
    if intention
      Intention.delete(intention.id)
    end
    redirect_to movie_path(params[:movie_id])
  end

private

  def intention_params
    params.require(:intention).permit(:user_id, :movie_id)
  end

end
