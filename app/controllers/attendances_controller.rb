class AttendancesController < ApplicationController
  before_action :is_current_user, only: [:index]
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @attendance = Attendance.new
    @event = Event.find(params[:id])
  end

  def show
  end

  def index
    @event = Event.find(params[:id])
  end

  def create
    # Before the rescue, at the beginning of the method
    @stripe_amount = @event.price
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
      redirect_to new_order_path
    end
    # After the rescue, if the payment succeeded

  end

  private

  def attendance_params
    attendance_params = params.require(:attendance).permit(:stripe_customer_id)
  end

  def is_current_user
    @user = current_user
    unless @user.id == Event.find(params[:id]).administrator.id
      flash[:danger] = "You don't have the permissions."
      redirect_to root_path
    end
  end
end
