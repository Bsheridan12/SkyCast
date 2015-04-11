class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.password == session_params[:password]
      session[:user_id] = user.id
      flash[:notice] = "Signed in as #{user.email}."
      # redirect_to workouts_path
      redirect_to dashboard_path      
    else
      @email = session_params[:email]
      flash[:alert] = "Email/password combination not valid."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end


  private
  def session_params
    params.require(:session).permit(:username, :password, :email)
  end
end