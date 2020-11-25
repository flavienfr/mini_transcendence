class LandingController < ApplicationController

  def index
  puts "inside LandingController#index"
      if (current_user)
        @users = User.all
      end
  end

  def update
  end


  def create
  end

  private

  def auth
  end
    
end
