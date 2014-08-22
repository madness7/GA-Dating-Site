class UsersController < ApplicationController

   before_filter :authenticate_user!

 

  def index
    puts params 
    puts '-' * 90 
    if params[:id] 
      puts 'I am inside the if statment'
      @user = User.find(params[:id])
    else #The methods defined in the user model that scope the search of the random match button are used below.
      @users = User.where("id != ?", current_user.id)
            @users = @users.looking(current_user.looking_for, current_user.gender)
            @users = @users.interests(@users, current_user.interests[0].name)
            @user = @users.shuffle.first
    end
    
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
    if params[:search]
      @users = User.search(params[:search])
    else
      @user_connections = UserConnection.where(user_2_id: current_user.id)
    end
  end


end
