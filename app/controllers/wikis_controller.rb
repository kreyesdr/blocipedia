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
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = 'Wiki saved successfully.'
      redirect_to @wiki

    else
      flash.now[:alert] = 'There was an error saving this wiki. Try again later or contact support'
    end

  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = 'Wiki updated successfully'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error updating this wiki. Try again later or contact support'
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted!"
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting this wiki'
      redirect_to wikis_path
    end
  end
end