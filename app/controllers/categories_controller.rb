class CategoriesController < ApplicationController 
  before_action :set_category, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create 
    @category = Category.new(category_params)
    if @category.save 
      redirect_to categories_path
    else
      render :new 
    end
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit 
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category updated successfully"
      redirect_to categories_path
    else
      render :edit 
    end
  end

  def destroy
    if @category.destroy
      flash[:danger] = "Category deleted successfully."
      redirect_to categories_path 
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "You are not authorized to perform this operation."
      redirect_to categories_path 
    end
  end
end