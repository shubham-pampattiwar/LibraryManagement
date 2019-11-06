class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]

  # GET /libraries
  # GET /libraries.json
  def index
    unless admin_signed_in? or librarian_signed_in?
      redirect_to :root, notice: 'Access Denied.'
    end
    @libraries = Library.all
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    @university = University.find(Library.find(params[:id]).university_id)
  end

  # GET /libraries/new
  def new
    unless admin_signed_in?
      redirect_to :root, notice: 'You need to be an admin to create libraries.'
    end
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
    unless admin_signed_in? or librarian_signed_in?
      redirect_to :root, notice: 'Access Denied.'
    end
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: 'Library was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name, :university_id, :location,:max_days_borrowed,:overdue_fines)
    end
end
