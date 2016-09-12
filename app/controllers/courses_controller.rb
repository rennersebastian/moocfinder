class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  PAGE_SIZE = 10
  
  # GET /courses
  # GET /courses.json
  def index
	@count = Course.all.count
  
	@page = (params[:page] || 0).to_i
	if params[:keywords].present?
		@keywords = params[:keywords]
		@courses = Course.search_keyword(@keywords).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
	else
		@courses = Course.all.offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
	end
  end
  
  # GET /courses/1
  # GET /courses/1.json
  def show
	@review = Review.new
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:courseURL, :description, :name, :startDate, :languages, :platform_id)
    end
end