class FranchisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :check_authentication, :except => [:show_all_franchise]
  # before_action :find_franchise, only: [:update, :destroy]

  def create
    byebug
    franchise = @curr_user.franchises.create!(franchise_params)
    render json: franchise, status: :ok
  end

  private

  def franchise_params
    params.permit(:name, :description, :address, :location)
  end

  def check_authentication
    if @curr_user.role == "customer"
      return render json: {message: "you're not an authorized person!"}
    end
  end
end


