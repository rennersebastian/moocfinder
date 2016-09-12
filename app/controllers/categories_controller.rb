class CategoriesController < ApplicationController
  before_action :set_platform, only: [:show]

  def index
    @categories = Category.all
  end
  
  def show
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(platform_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_platform
      @category = Category.find(params[:id])
    end

    def platform_params
      params.require(:category).permit(:name, :subCategories)
    end
end
