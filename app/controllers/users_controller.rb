class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # @request = Request.find(params[:id])
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @requests = @user.requests
  end


end
