class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  #before_action :is_current_user, only: [:create]

  def show
    @event = Event.find(params[:id])
  end

  def index
    @event = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.administrator = current_user
    if @event.save
      @event.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "Card.png")), filename: 'Card.png' , content_type: "image/png")
      flash[:success] = "Félicitations ! L'événement a été créé !"
      redirect_to root_path
    else
      flash.now[:error] = "L'événement n'a pas été créé ! Veuillez réessayer."
      render new_event_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(params[:id])
    else
      flash.now[:error] = "L'événement n'a pas été modifié ! Veuillez réessayer."
      render edit_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Félicitations ! L'événement a été supprimé !"
      redirect_to root_path
    else
      flash.now[:error] = "L'événement n'a pas été détruit ! Veuillez réessayer."
      render event_path
    end
  end

  private

  def event_params
    event_params = params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :image)
  end

  def is_current_user
    unless current_user.id == Event.find(params[:id]).administrator || current_user.admin == true
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

end
