class SessionsController < ApplicationController

def new
end

def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    flash[:success] = "Logged in successfully!"
    redirect_to user
  else
    flash.now[:danger] = "There was something wrong with your login details"
    render "new"
  end
  #flash.now is used when we dont redirect to another page, is shows up "now"
  # params[:session][:email]
  # params[:session][:password]
end

def destroy
  session[:user_id] = nil
  flash[:success] = "Logged out"
  redirect_to root_path
end

end
