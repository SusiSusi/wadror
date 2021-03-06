class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password]) && user.chilled
      redirect_to :back, notice: "Your account is frozen. Please contact admin"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def create_oauth
    user = User.find_by username: env["omniauth.auth"].info.nickname
    user.update_attribute(:github, true)
    byebug
    if user && user.chilled
      redirect_to :back, notice: "Your account is frozen. Please contact admin"
    else
    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Welcome back!"
    end
  end
end