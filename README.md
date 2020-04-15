# README

Migrate a new db table : rails generate migration create_articles
Edit the db file create_articles.rb 
 t.string :title 
t.text :description 

run rails db:migrate 
new schema.rb file is updated 

Article model 
>in models > create article.rb 
class Article < ApplicationRecord 
end 

run rails console 
Work with the db in the console 
CRUD CREATE 
Article.all 
Article.create(title: "", description: "")
article = Article.new 
  article.title = ""
  article.description = ""
  article.save 
article = Article.new(title: "", description: "")
  article.save
Article.all > shows all the object articles inside the Article class array 

# CRUD READ => Show 
  def show
      @article = Article.find(params[:id])
    end

  #Index to show all the articles of my db
  def index 
    @articles = Article.all
  end

# CRUD new & CREATE 
 def new 
    @article = Article.new
  end 

   def create 
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article was created succesfully !"
      redirect_to @article
    else
      render "new"
    end
  end

  # CRUD edit & UPDATE
    def edit
      @article = Article.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])
      if @article.update(params.require(:article).permit(:title, :description))
        flash[:notice] = "Article was succesfully updated !"
        redirect_to @article
      else
        render "edit"
      end
    end

# ADD BOOTSTRAP and JAVASCRIPT (jquery and popper.js) 

# Code inside cinfig/webpack/environment.js
    const webpack = require("webpack")
    environment.plugins.append("Provide", new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: ['popper.js', 'default']
    }))

# Inactivate rails default div creation when validation errors 
> config > environnment.rb 
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

# Email validation 
> user and email uniqueness 
  uniqueness: true

> Email format validation 
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Ruby constant
  validates :email, ...., format: { with: VALID_EMAIL_REGEX }

# Display Gravatar Profile Image 
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "profile-img mt-4 rounded shadow mx-auto d-block")
  end

  > only shows an image if the user has a wordpress account... need to upgrade to a simple add image file and default profile image function ! 
