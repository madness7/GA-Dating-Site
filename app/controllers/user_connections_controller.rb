class UserConnectionsController < ApplicationController
  # GET /user_connections
  # GET /user_connections.json
  def index
    @user_connections = UserConnection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_connections }
    end
  end

  # GET /user_connections/1
  # GET /user_connections/1.json
  def show
    @user_connection = UserConnection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_connection }
    end
  end

  # GET /user_connections/new
  # GET /user_connections/new.json
  def new
    @user_connection = UserConnection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_connection }
    end
  end

  # GET /user_connections/1/edit
  def edit
    @user_connection = UserConnection.find(params[:id])
  end

  # POST /user_connections
  # POST /user_connections.json
  def create
    @user_connection = UserConnection.new(params[:user_connection])

    respond_to do |format|
      if @user_connection.save
        format.html { redirect_to @user_connection, notice: 'User connection was successfully created.' }
        format.json { render json: @user_connection, status: :created, location: @user_connection }
      else
        format.html { render action: "new" }
        format.json { render json: @user_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_connections/1
  # PUT /user_connections/1.json
  def update
    @user_connection = UserConnection.find(params[:id])

    respond_to do |format|
      if @user_connection.update_attributes(params[:user_connection])
        format.html { redirect_to @user_connection, notice: 'User connection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_connections/1
  # DELETE /user_connections/1.json
  def destroy
    @user_connection = UserConnection.find(params[:id])
    @user_connection.destroy

    respond_to do |format|
      format.html { redirect_to user_connections_url }
      format.json { head :no_content }
    end
  end
end
