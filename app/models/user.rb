class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Callbacks to handle creating and deleting Stripe customers
  after_create :create_stripe_customer
  after_sign_in :create_stripe_customer
  before_destroy :delete_stripe_customer



  private 

  def create_stripe_customer
    if stripe_customer_id.blank?
      customer = Stripe::Customer.create(  #Creates a Stripe customer with the user model information
        email: email, 
        name: name,
        phone: phone_number,
      )
      self.stripe_customer_id = customer.id #Sets the stripe_customer_id in database to customer.id (customer.id is returned from stripe after creating the customer)
      save
    end
  end

  def delete_stripe_customer #Deletes the stripe customer if user deletes their account on the app
    if stripe_customer_id.present?
      Stripe::Customer.delete(stripe_customer_id)
    end
  end
end
