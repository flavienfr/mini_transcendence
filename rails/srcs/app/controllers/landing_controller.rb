class LandingController < ApplicationController

  def index
    @users = User.all
    #@users.each do |user|
     #  user.destroy()
    # end

  end

  def update
  end


  def create
  end


  private
  
    def user_params
      params.require(:user).permit(:name, :avatar, :current_status, :points, :is_admin)
    end


end
