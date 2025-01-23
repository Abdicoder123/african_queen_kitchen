class ReviewsController < ApplicationController
        before_action :set_review, only: [ :show, :edit, :update, :destroy ]
        before_action :set_dish, only: [ :new, :create ]

        def index
          @reviews = Review.all
        end

        def show
            @review
        end


        def new
            @review = @dish.reviews.build
        end


        def create
          @review = @dish.reviews.build(review_params)
          @review.user_id = current_user.id

          if @review.save
            redirect_to @dish, notice: "Review was successfully created."
          else
            render :new
          end
        end

        def edit
            @review
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
          redirect_to @review.dish, notice: "Review was successfully destroyed."
        end

        private
          def set_review
            @review = Review.find(params[:id])
          end

          def set_dish
            @dish = Dish.find(params[:dish_id])
          end

          def review_params
            params.require(:review).permit(:rating, :comment)
          end
end
