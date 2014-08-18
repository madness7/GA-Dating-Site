class UsersController < ApplicationController
  
  def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to @user, :notice => "Successfully created user."
      else
        render :action => 'new'
      end
    end

  def show
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end
