class UsersController < ApplicationController
  private

  def user_params
      params.require(:user).permit(:name, :address, :phone_number, :email)
  end
end
