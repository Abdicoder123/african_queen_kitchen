class ReviewsController < ApplicationController
    # Ensure that only logged-in users can create reviews
    before_action :authenticate_user!, only: [ :new, :create ]

    before_action :set_review, only: [ :show, :edit, :update, :destroy ]

    # Ensure that users can only edit or delete their own reviews
    before_action :authorize_review, only: [ :edit, :update, :destroy ]

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
      @review.user_id = current_user.id  # Associate review with the current user

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

    # Set the review based on the ID in the params
    def set_review
      @review = Review.find(params[:id])
    end

    # Ensure only the owner of the review can edit or delete it
    def authorize_review
      if @review.user != current_user
        redirect_to reviews_path, alert: "You are not authorized to modify this review."
      end
    end

    # Permit only rating and comment params for review creation and update
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
