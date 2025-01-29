# app/services/customer_update_service.rb
class CustomerUpdateService
    def initialize(user, customer_params)
      @user = user
      @customer_params = customer_params
    end
  
    def call
      return unless @user.stripe_customer_id.present?
  
      begin
        # Fetch the Stripe customer using the stored Stripe customer ID
        customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
  
        # Update the Stripe customer with the provided parameters
        customer.update(@customer_params)
  
        # Save any updated user details (if applicable)
        @user.update(email: @customer_params[:email]) if @customer_params[:email].present?
  
        true
      rescue Stripe::StripeError => e
        Rails.logger.error "Stripe Customer Update Error: #{e.message}"
        false
      end
    end
  end
  