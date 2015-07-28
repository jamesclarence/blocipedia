class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    if @wiki.save
      flash[:notice] = "Wiki article was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
     flash[:notice] = "Wiki article was updated."
     redirect_to @wiki
    else
     flash[:error] = "There was an error saving the wiki. Please try again."
     render :edit
    end
  end
end
