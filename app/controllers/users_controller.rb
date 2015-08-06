class UsersController < ApplicationController
  def premium_to_standard
    current_user.update_attributes(role: 'standard')
    redirect_to edit_user_registration_path
  end
end
