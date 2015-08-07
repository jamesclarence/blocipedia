class WikisController < ApplicationController
  def index
    @wikis = Wiki.all.sort_by{|a|a.title}
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    authorize @wiki
    
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
     flash[:notice] = "Wiki article was updated."
     redirect_to @wiki
    else
     flash[:error] = "There was an error saving the wiki. Please try again."
     render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
     flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
     redirect_to @wiki
    else
     flash[:error] = "There was an error deleting the wiki."
     render :show
   end
  end
end
