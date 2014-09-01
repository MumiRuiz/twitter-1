class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
        render text: "User authenticated successfully!"
    else
      @user = User.new
      render :new, alert: "Username or password invalid"
    end
    # if a
    #   if b
    #     something()
    #   else
    #     something_else()
    #   end
    # else
    #   something_else()
    # end

    # if a && b
    #   something()
    # else
    #   something_else()
    # end
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
