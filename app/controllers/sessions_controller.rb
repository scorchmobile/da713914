# Authentication Routes and Logic
class SessionsController < ApplicationController

  layout 'cms'

  before_action :set_session, only: [:show, :edit, :update, :destroy]


  # Load the form
  def new
    # Logic
  end

  # Save the values
  def create
    user_id = Knowmadics.sign_in(session_params[:username], session_params[:password])
    if user_id
      session[:current_user] = UserInterface.new(user_id: user_id)
      session[:user_id] = user_id
      session[:logged_in] = true
    else
      redirect_to new_session_path, alert: 'Incorrect Email or Password.'
    end
  end

  # Kill the values
  def destroy
    session.delete(:current_user)
    session.delete(:logged_in)
    session.delete(:user_id)
    redirect_to root_url, notice: 'Successfully Logged Out.'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:user).permit(:username, :password, :remember_me)
    end
end
