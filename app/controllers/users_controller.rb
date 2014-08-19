class UsersController < ApplicationController

   before_filter :authenticate_user!

 

  def index
    @user = User.find(:all, :conditions => { :gender => current_user.looking_for })
    @match = @user.shuffle.first
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
        format.html { redirect_to @user, notice: 'User connection was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
