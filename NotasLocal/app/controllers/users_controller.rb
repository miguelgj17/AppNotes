class UsersController < ApplicationController
  before_action :authenticate!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

      if @user.save
        session[:user] = @user.id
        session[:username] = @user.name
        session[:admin] = @user.admin
        redirect_to notes_url, :notice => "Logged in!"
      else
        render :new
      end
    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|

      if @user.id == session[:user] || (session[:admin] == true)

          if @user.update(update_params)
            format.html { redirect_to @user, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      else
          format.html { redirect_to users_url, alert: 'You cannot edit another user' }
          format.json { head :no_content }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.id == session[:user] || (session[:admin] == true)
          @user.destroy
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
      else
          format.html { redirect_to users_url, alert: 'You cannot delete another user' }
          format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :admin)
    end
    def update_params
      params.require(:user).permit(:password, :admin)
    end
end
