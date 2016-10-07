class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where('username LIKE ?', "%#{params[:search]}%")
                .all_except(current_user)
                .exclude_collaborators(@wiki)
                .first
    if @user
      @collaborator = Collaborator.new(wiki: @wiki, user: @user)
      if @collaborator.save
        flash[:notice] = 'User collaborator successfully added to wiki.'
      else
        flash[:error] = 'There was a problem adding user. Please try again.'
      end
    else
      flash[:error] = "Sorry that wasn't a valid username. Please try again."
    end
    redirect_to @wiki
  end


  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = 'Member removed from wiki.'
    else
      flash[:error] = 'Member removed from wiki.'
    end
    redirect_to @wiki
  end

end
