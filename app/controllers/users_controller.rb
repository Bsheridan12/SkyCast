class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      @errors = @user.errors
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    if logged_in?
      render :dashboard
    else
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :image_url)
  end
end