class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    wikis_path
  end

end
