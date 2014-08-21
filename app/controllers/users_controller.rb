class UsersController < ApplicationController

   before_filter :authenticate_user!

 

  def index
    puts params 
    puts '-' * 90 
    if params[:id] 
      puts 'I am inside the if statment'
      @user = User.find(params[:id])
    else
      puts '-' * 90 
      puts current_user
      puts current_user.id
      users1 = User.where("id != ?", current_user.id)
      puts '1' * 90 
      puts users1
      users2 = users1.looking(current_user.looking_for, current_user.gender)
      puts '2' * 90 
      puts users2
      users3 = users2.interests(users2, current_user.interests[0].name)
      puts '3' * 90 
      puts users3
      @user = users3.shuffle.first
      puts '4' * 90 
      puts @user
      puts @user.id
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
  @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        format.html { redirect_to @user, notice: 'User connection was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def connections
    if params[:search]
      @users = User.search(params[:search])
    else
      @user_connections = UserConnection.where(user_2_id: current_user.id)
    end
  end


end
