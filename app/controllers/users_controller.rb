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
    ForecastIO.api_key = "b5600c8d9df775b6c3bbdd0f449b53b3"

    @forecast = ForecastIO.forecast(params[:latitude], params[:longitude])

    p "--------------------------------------"
    p params[:latitude]
    p @forecast
    
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