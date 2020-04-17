
class ArticlesController < ApplicationController
  # before actions allways in order ! 
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index 
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new 
    @article = Article.new
  end 

  def edit
  end

  def create 
    @article = Article.new(article_params) #Security to admit creation, or update 
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created succesfully !"
      redirect_to @article
    else
      render "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was succesfully updated !"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    flash[:warning] = "The article has been deleted"
    redirect_to user_path(@article.user)
  end

  private

  def require_same_user
    if current_user!= @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
