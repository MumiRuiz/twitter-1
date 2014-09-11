class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :favorites, :followers, :followings]

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

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
  user = User.find(params[:id])
  unless current_user.follow(user)
  flash[:error] = "Yous cannot follow yourself"
  end
   redirect_to :back
  end

  def unfollow
    user = User.find(params[:id])
    unless current_user.follow(user)
    flash[:error] = "Yous cannot follow yourself"
  end
    redirect_to :back
  end

def favorites
  user = User.find(params[:id])
  @favorites = user.favorite_tweets
end

def followings
  user = User.find(params[:id])
  @followings = user.followings
end

def followers
  user = User.find(params[:id])
  @followers = user.followers
  
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:user).permit(:username, :email, :password, :password_confirmation, :cover_photo, :profile_picture, :location, :private, :bio, :website, :timezone, :language, :phone, :verified, :name)
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :name)
    end
end
