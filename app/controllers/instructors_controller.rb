class InstructorsController < ApplicationController
  before_action :set_platform, only: [:show]
  PAGE_SIZE = 10

  # GET /instructors
  # GET /instructors.json
  def index
	@count = Instructor.all.count
	@page = (params[:page] || 0).to_i
    @instructors = Instructor.all.offset(PAGE_SIZE * @page).limit(PAGE_SIZE)    
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
  end
  
  # GET /instructors/new
  def new
    @instructor = Instructor.new
  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
        format.json { render :show, status: :created, location: @instructor }
      else
        format.html { render :new }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_platform
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def platform_params
      params.require(:instructor).permit(:name, :description, :address, :logoRef)
    end
end
