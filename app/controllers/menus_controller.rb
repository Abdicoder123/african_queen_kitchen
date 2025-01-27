class MenusController < ApplicationController
  def index
    @menus = Menu.all
    @dishes = Dish.all
    
  end

  def show
    @menu = Menu.find(params[:id])
  end

  private
    def menu_params
      params.permit(:title, :description, :category, :active, :special_notes)
    end
end
