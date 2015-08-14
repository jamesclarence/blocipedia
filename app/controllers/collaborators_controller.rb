class CollaboratorsController < ApplicationController
  def index
  end

  def new
    @collaborator = Collaborator.new
    @user = User.all
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id: params[:user_id], wiki_id: params[:wiki_id])

    if @collaborator.save
      flash[:notice] = "You added a collaborator for your wiki."
    else
      flash[:error] = "There was an error adding this collaborator. Please try again."
      render :new
    end
  end

  def show
  end

  def destroy
  end
end
