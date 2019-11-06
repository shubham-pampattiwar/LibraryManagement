class LibrariansController < ApplicationController
  before_action :authenticate_librarian
  before_action :set_librarian, only: [:show, :edit, :update, :destroy]


  # GET /librarians
  # GET /librarians.json
  def index
    if admin_signed_in?
      sign_out :librarian
      redirect_to root_path
    end
    @librarians = Librarian.all
  end

  def specialcollectionbooks
    @req_coll = []
    @lib = Library.where(id: current_librarian.library_id).first
    @books_lib = Book.where(library_id: @lib.id)
    @books_lib.each do |book_lib|
      @req_coll << HoldRequest.where(book_id: book_lib.id, approved: false)
    end

  end
  def approve_sprequest
    req_id = params[:id]
    spreqobj = HoldRequest.where(id: req_id).first
    spreqobj.approved = true
    spreqobj.save!
    @student = Student.find(spreqobj.student_id)
    @book = Book.find(spreqobj.book_id)
    @library = Library.where(id: @book.library_id).first
    checkout_count = BookIssueHistory.where(:student_id => @student.id,:return_date  => nil).count
    if @book.quantity > 0 && checkout_count != @student.max_books_borrowed
      issue_date = Date.today
      overdue_date = issue_date + (@library.max_days_borrowed).days
      @book_issue_history = BookIssueHistory.new
      @book_issue_history.book_id = @book.id
      @book_issue_history.library_id = @book.library_id
      @book_issue_history.student_id = @student.id
      @book_issue_history.issue_date = issue_date
      @book_issue_history.overdue_date = overdue_date
      @book.decrement(:quantity)
      @book.save!
      @book_issue_history.save!
      redirect_to deleterequest_path(:request_id => spreqobj.id)
      return
    end
    redirect_to('/specialcollectionbooks')
    return
  end

  # GET /librarians/1
  # GET /librarians/1.json
  def show
  end

  # GET /librarians/new
  def new
    @librarian = Librarian.new
  end

  # GET /librarians/1/edit
  def edit
  end

  # POST /librarians
  # POST /librarians.json
  def create
    @librarian = Librarian.new(librarian_params)

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to @librarian, notice: 'Librarian was successfully created.' }
        format.json { render :show, status: :created, location: @librarian }
      else
        format.html { render :new }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /librarians/1
  # PATCH/PUT /librarians/1.json
  def update
    respond_to do |format|
      if @librarian.update(librarian_params)
        format.html { redirect_to @librarian, notice: 'Librarian was successfully updated.' }
        format.json { render :show, status: :ok, location: @librarian }
      else
        format.html { render :edit }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /librarians/1
  # DELETE /librarians/1.json
  def destroy
    @librarian.destroy
    respond_to do |format|
      format.html { redirect_to librarians_url, notice: 'Librarian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_librarian
    unless librarian_signed_in? or admin_signed_in?
      redirect_to new_librarian_session_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_librarian
    @librarian = Librarian.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def librarian_params
    params.require(:librarian).permit(:password, :email)
  end
end
