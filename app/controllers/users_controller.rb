class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user

    if @user.update(user_params)
      # Call Stripe update service
      if CustomerUpdateService.new(@user, stripe_customer_params).call
        flash[:notice] = "Profile and Stripe customer updated successfully."
      else
        flash[:alert] = "Profile updated, but Stripe customer update failed."
      end
      redirect_to profile_path
    else
      flash[:alert] = "Error updating profile."
      render :edit
    end
  end

  private

  def stripe_customer_params
    params.require(:user).permit(:name, :address, :phone_number, :email)
  end

  def user_params
      params.require(:user).permit(:name, :address, :phone_number, :email)
  end
end
