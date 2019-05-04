class FriendsController < ApplicationController
  before_action :authenticate!

  def index
  	@friends = current_user.friends
    @users = User.where("NOT id = ? ", session[:user])

    if(session[:admin] == true)
      @friendships = Friendship.all
    else
      @friendships = Friendship.where("user_id = ? OR friend_id = ?", session[:user], session[:user])
    end

  end

  def destroy
  	current_user.remove_friend(@friend)
  	head :no_content
  end

  private

  def set_friend
  	@friend = current_user.friends.find(params[:id])
  end

end
