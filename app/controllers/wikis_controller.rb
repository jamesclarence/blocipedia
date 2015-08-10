class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).all
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
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
    
    if @wiki.update_attributes(wiki_params)
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

  # def public_wiki_to_private
  #   @wiki = Wiki.find(params[:public])
    
  #   if @wiki.update_attributes(public: false)
  #     flash[:notice] = "Wiki changed to Private."
  #     redirect_to @wiki
  #   else
  #     flash[:error] = "There was an error updating the wiki."
  #   end
  # end

  private

  def wiki_params
    params.require(:wiki).permit(:id, :title, :body, :public)
  end
end
