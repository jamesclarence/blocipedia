class ChargesController < ApplicationController
  def create
    
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id # Note -- not user_id in app
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
      )

    flash[:success] = "Thank you for your payment, #{current_user.email}!"
    redirect_to user_path(current_user)

    # Stripe will send back CardErrors, with friendly messages
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end

    def amount
      amount = 15_00
    end

    def default
      amount
    end

  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end
end
