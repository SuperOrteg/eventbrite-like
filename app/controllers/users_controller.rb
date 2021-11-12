class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :edit]
	before_action :is_current_user, only: [:show, :edit]

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


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(params[:id])
    else
      flash.now[:alert] = "L'utilisateur n'a pas été modifié ! Veuillez réessayer."
      render edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash.now[:alert] = "Félicitations ! Le user a été supprimé !"
      redirect_to admin_path
    else
      flash.now[:alert] = "Le user n'a pas été détruit ! Veuillez réessayer."
      render user_path
    end
  end

  private

  def is_current_user
    unless current_user.id.to_i == params[:id].to_i || current_user.admin == true
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

  def user_params
    user_params = params.require(:user).permit(:first_name, :last_name, :description, :email)
  end

end
