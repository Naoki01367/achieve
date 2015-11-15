class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:id])
  end
end

def followers
  @user = User.find{params[:id]}
  @users = @user.followers.paginate(page: params[:page])
  render 'show_follow'
end