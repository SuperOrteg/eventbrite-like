class AttendancesController < ApplicationController
  before_action :is_current_user, only: [:index]
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @attendance = Attendance.new
    @event = Event.find(params[:event_id])
  end

  def show
  end

  def index
    @event = Event.find(params[:event_id])
  end

  def create
    @amount = Event.find(params[:id]).price
    @event = Event.find(params[:id])
    # Before the rescue, at the beginning of the method
    @stripe_amount = (@amount * 100).to_i
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to attendance_path
    end
    # After the rescue, if the payment succeeded
    @attendance = Attendance.create(stripe_customer_id: params[:id].to_s, user: current_user, event: @event)
    redirect_to root_path
  end

  private

  def is_current_user
    @user = current_user
    unless @user.id == Event.find(params[:event_id]).administrator.id
      flash[:danger] = "You don't have the permissions."
      redirect_to root_path
    end
  end
end
