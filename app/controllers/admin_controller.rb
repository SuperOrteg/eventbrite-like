class AdminController < ApplicationController
  before_action :is_current_user, only: [:index]

  def show
    @events = Event.all
  end
  
  def index
    @users = User.all
  end

  private

  def is_current_user
    unless current_user.admin == true
      flash[:error] = "You do not have the permissions."
      redirect_to root_path
    end
  end
end
