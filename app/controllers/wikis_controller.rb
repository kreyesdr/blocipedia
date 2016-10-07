class WikisController < ApplicationController

  def index
    @wiki = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    authorize @wiki, :create?
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = 'Wiki saved successfully.'
      redirect_to @wiki

    else
      flash.now[:alert] = 'There was an error saving this wiki. Try again later or contact support'
    end

  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @collaborator = Collaborator.new
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki, :update?
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = 'Wiki updated successfully'
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error updating this wiki. Try again later or contact support'
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted!"
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting this wiki'
      redirect_to wikis_path
    end
  end
end
