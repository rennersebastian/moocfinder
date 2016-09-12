class PlatformsController < ApplicationController
  before_action :set_platform, only: [:show]
  PAGE_SIZE = 10

  # GET /platforms
  # GET /platforms.json
  def index
	@count = Platform.all.count
	@page = (params[:page] || 0).to_i
    @platforms = Platform.all.offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
  end

  # GET /platforms/1
  # GET /platforms/1.json
  def show
  end
  
  # GET /platforms/new
  def new
    @platform = Platform.new
  end

  # POST /platforms
  # POST /platforms.json
  def create
    @platform = Platform.new(platform_params)

    respond_to do |format|
      if @platform.save
        format.html { redirect_to @platform, notice: 'Platform was successfully created.' }
        format.json { render :show, status: :created, location: @platform }
      else
        format.html { render :new }
        format.json { render json: @platform.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @platform = Platform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_params
      params.require(:platform).permit(:name, :description, :address, :logoRef)
    end
end
