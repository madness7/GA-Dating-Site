class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end
