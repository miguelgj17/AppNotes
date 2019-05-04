class FriendRequestsController < ApplicationController
  before_action :authenticate!
  before_action :set_friend_request, only: [:create, :update, :destroy]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index

  	@incoming = FriendRequest.where(friend: current_user)
  	@outgoing = current_user.friend_requests
    @users = User.where("NOT id = ? ", session[:user])

    @myfriends = Friendship.where("(user_id = ? OR friend_id = ?) ", session[:user], session[:user])
    @friends = Friendship.where("(NOT user_id = ? AND NOT friend_id = ?) ", session[:user], session[:user])
  end

  def destroy
  	@friend_request.destroy
  	head :no_content
  end

  def update
  	@friend_request.accept
  	head :no_content
  end
  

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
