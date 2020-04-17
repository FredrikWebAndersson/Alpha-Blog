class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]

  def show 
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def edit 
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was successfully updated!"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def create 
    @user = User.new(user_params) #Security to admit creation, or update
    if @user.save 
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up!"
      redirect_to articles_path
    else
      render "new"
    end
    
  end 

  private

  def require_same_user
    if current_user != @user
      flash[:warning] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
