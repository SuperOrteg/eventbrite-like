class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show]
	before_action :is_current_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @event = Event.where(administrator_id: params[:id])
  end

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  private

  def is_current_user
    unless current_user.id.to_i == params[:id].to_i || @user.admin == true
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end
end
