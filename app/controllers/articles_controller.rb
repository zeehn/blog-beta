class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show]
  before_action :require_owner, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article created successfully."
      redirect_to @article
    else
      render :new
    end
  end

  def show 
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article updated successfully."
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:danger] = "Article deleted successfully."
      redirect_to articles_path
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_owner
    if @article.user != current_user and !current_user.admin?
      flash[:danger] = "You are not authorized to perform this operation"
      redirect_to articles_path
    end
  end
end