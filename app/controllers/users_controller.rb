class UsersController < ApplicationController

   before_filter :authenticate_user!

 

  def index
    ## if there is a user id passed go to that user.  otherwise select user based on current_user
    if params[:id] 
      @user = User.find(params[:id])
    else
      @users = User.where("id != ?", current_user.id)
      @users = @users.looking(current_user.looking_for, current_user.gender)
      @users = @users.interests(@users, current_user.interests[0].name)
      @user = @users.shuffle.first
    end
    ## finding if there is a connection between the current user and the user displayed
    @connections = current_user.user_connections
    @connections.each do |c|
      if c.user_2_id == @user.id
        @c=c.id
      end
    end
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @match }
      end
    end

  def show

    @user = User.find(current_user.id)

    respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
  
  end
  def connections
    ## showing the return values of the search or the users that have liked you.s
    if params[:search]
      @users = User.search(params[:search])
    else
      @user_connections = UserConnection.where(user_2_id: current_user.id)
    end
  end


end
