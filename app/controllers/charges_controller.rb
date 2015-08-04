class ChargesController < ApplicationController
  def new
  end

  def create

    @amount = 1500
    
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- not user_id in app
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
      )

    if current_user.update(role: 'premium')
      flash[:success] = "Thank you for upgrading to Premium, #{current_user.email}!"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error upgrading your account."
      redirect_to edit_user_registration_path
    end

    # Stripe will send back CardErrors, with friendly messages
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def destroy
    if current_user.premium?
      cu = Stripe::Customer.retrieve({customer_id})
      cu.delete
      current_user.update(role: 'standard')
      flash[:success] = "You downgraded from Premium to Standard, #{current_user.email}!"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error upgrading your account."
      redirect_to edit_user_registration_path
    end

    # if @user.premium_to_standard
    #   flash[:notice] = "Membership downgraded to Standard."
    #   redirect_to edit_user_registration_path
    # else
    #   flash[:error] = "There was an error downgrading your account."
    #   redirect_to edit_user_registration_path 
    # end
  end 

end
