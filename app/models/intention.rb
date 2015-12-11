class Intention < ActiveRecord::Base
  belongs_to :users
  belongs_to :movies

  def create
    unless Intention.where(:user_id => current_user.id, :movie_id => intention_params[:movie_id])
      Intention.create(intention_params)
      redirect_to movies_path
    end
  end

private

  def intention_params
    params.require(:intention).permit(:user_id, :movie_id)
  end

end
