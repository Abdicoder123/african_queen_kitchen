class ReviewsController < ApplicationController
    before_action :set_review, only: [ :show, :edit, :update, :destroy ]


    def index
      @reviews = Review.all
    end

    def show
    end

    def new
      @review = Review.new
    end

    def create
      @review = Review.new(review_params)
      @review.user_id = current_user.id

      if @review.save
        redirect_to reviews_path, notice: "Review was successfully created."
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @review.update(review_params)
        redirect_to @review, notice: "Review was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @review.destroy
      redirect_to reviews_path, notice: "Review was successfully destroyed."
    end

    private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
