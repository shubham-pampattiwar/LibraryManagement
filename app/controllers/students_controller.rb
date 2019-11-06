class StudentsController < ApplicationController
  before_action :authenticate_student
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  # GET /students
  # GET /students.json
  def index
    if admin_signed_in?
      sign_out :student
      redirect_to root_path
    end
    @students = Student.all
  end

  def getstudentlibraries
    #@student_libraries = Library.all 
    @student_libraries = Library.where('university_id = ?', params[:university_id])
  end

  def showstudentprofile
    @student_profile = Student.where('id = ?', current_student.id).first
    @student_university = University.first(current_student.university_id).first
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @university = University.find(Student.find(params[:id]).university_id)
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # students login
  def login
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    if @student.education_level == "Bachelors"
      @student.max_books_borrowed = 10
    elsif @student.education_level == "Masters"
      @student.max_books_borrowed = 20
    else
      @student.max_books_borrowed = 30
    end

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json


  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_student
    unless student_signed_in? or admin_signed_in?
      redirect_to new_student_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :education_level, :university_id, :max_books_borrowed)
    end
end
