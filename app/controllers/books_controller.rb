class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  require 'date'
 # before_action :new, :check_if_student
  # GET /books
  # GET /books.json

  def index
    check_if_student
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @library = Library.find(Book.find(params[:id]).library_id)
  end

  # GET /books/new
  def new
    check_if_student
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    unless admin_signed_in? or librarian_signed_in?
      redirect_to :root, notice: 'You must be signed in as an admin or a librarian to add books.'
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_if_student
    unless admin_signed_in? or librarian_signed_in?
      redirect_to :root, notice: 'You must be signed in as an admin or a librarian to add books.'
    end
  end

  def getlibrarybooks
    @library_books = Book.where('library_id = ?', params[:library_id])
    #puts "Librarian #{@librarian.id}"
    #puts "library_books #{@library_books}"
  end

  def showrequests
    @requested_books = []
    @requests = HoldRequest.where(student_id: current_student.id)
    @requests.each do  |request|
      @requested_books << Book.where('id = ?', request.book_id)
    end
  end

  def showrequestsforlib
    @req = []
    @lib = Library.where(id: current_librarian.library_id).first
    @books_lib = Book.where(library_id: @lib.id)
    @books_lib.each do |book_lib|
      @req << HoldRequest.where(book_id: book_lib.id)
    end
   # @custom = Book.joins(:hold_requests).where("hold_requests.book_id" => book_id).where(library_id: @lib.id)
  end

  def showrequestsforadmin
    @req = []
    @books_lib = Book.all
    @books_lib.each do |book_lib|
      @req << HoldRequest.where(book_id: book_lib.id)
    end
  end

  def checkedoutbookslib
    @hists = []
    @lib = Library.where(id: current_librarian.library_id).first
    @books_lib = Book.where(library_id: @lib.id)
    @books_lib.each do |book_lib|
      @hists << BookIssueHistory.where(book_id: book_lib.id, return_date: nil)
    end
  end

  def bookhistlib
    @hists = []
    @lib = Library.where(id: current_librarian.library_id).first
    @books_lib = Book.where(library_id: @lib.id)
    @books_lib.each do |book_lib|
      @hists << BookIssueHistory.where(book_id: book_lib.id)
    end
  end 

  def borrowhistory
    req_id = params[:id]
    @bookborrowhistory = BookIssueHistory.where(book_id:req_id)
  end


  def deleterequest
    @request = HoldRequest.where(id: params[:request_id]).first
    @otherRequests = HoldRequest.where(:book_id => @request.book_id).where('queuenumber > ?' ,@request.queuenumber)
    respond_to do |format|
      if @request.destroy
        @otherRequests.each do |otherRequest|
            otherRequest.decrement(:queuenumber)
            otherRequest.save!
        end
        format.html { redirect_to :root, notice: 'Request was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def getstudentbooks
    @student_books = []
    @libraries = Library.where('university_id = ?', params[:university_id])
    @libraries.each do |lib|
       @student_books << Book.where('library_id = ?',lib.id)
       end  
  end


  def displaysearch
      text = params[:search]
      criteria = params[:search_by]
      @searched_books = Array.new
      @libraries = Library.where('university_id = ?', current_student.university_id)
      if (criteria == 'publication date')
        @libraries.each do |lib|
        @searched_books.push Book.where('published' + ' = ?', text).where('library_id  = ?', lib.id)
        end
      else
        @libraries.each do |lib|
        @searched_books.push Book.where('lower('+ criteria +') like ?', '%'+text+'%').where('library_id  = ?', lib.id)
      end
    end
  end


  def search
  end


  def checkout
    @student = Student.find(params[:student_id])
    @book = Book.find(params[:book_id])
    @library = Library.where(id: @book.library_id).first
    checkout_count = BookIssueHistory.where(:student_id => @student.id,:return_date  => nil).count
    quantity = @book.quantity
    if BookIssueHistory.where(:student_id => @student.id, :book_id => @book.id,:return_date  => nil).first.nil?
        if checkout_count == @student.max_books_borrowed || @book.special_collection
        #redirect_to request.referrer, notice: "Maximum books checked out already"
        hold_request(@student,@book,checkout_count)
        return
        end
      if quantity > 0
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
        respond_to do |format|
          if @book_issue_history.save
            UserMailer.checkout_email(@student,@book).deliver_now
            format.html { redirect_to :students, notice: 'Book successfully checked out.' }
            format.json { render :show, status: :created, location: @book_issue_history }
          else
            format.html { render :new }
            format.json { render json: @book_issue_history.errors, status: :unprocessable_entity }
          end
        end
      else
        hold_request(@student, @book,checkout_count)
      end
    else
      redirect_to :students, notice: 'Book already checked out.'
      end
  end

  def hold_request (student , book, checkout_count)
    if HoldRequest.where(student_id: student.id, book_id: book.id).first
      redirect_to :students, notice: 'No books available, your hold request has already been placed'
    else
      @holdRequest = HoldRequest.new
      @holdRequest.book_id = book.id
      @holdRequest.student_id = student.id
      @otherRequests = HoldRequest.where(:book_id => book.id)
      maxcount = 0
      @otherRequests.each do |otherRequest|
        if otherRequest.queuenumber > maxcount
          maxcount = otherRequest.queuenumber
        end
      end
      maxcount += 1
      @holdRequest.queuenumber = maxcount

      unless @book.special_collection
        @holdRequest.approved = true
      end

      respond_to do |format|
        if @holdRequest.save
        UserMailer.holdrequest_email(student,book).deliver_now
          if checkout_count == student.max_books_borrowed
            format.html { redirect_to :students, notice: "You have reached your book limit, Hold request created your number in queue is #{@holdRequest.queuenumber}" }
          elsif @book.special_collection
          format.html { redirect_to :students, notice: "Hold request created, your number in queue is
                #{@holdRequest.queuenumber}.\nBook will be issued pending approval" }
          format.json { render :show, status: :created, location: @holdRequest }
          else
            format.html { redirect_to :students, notice: "Hold request has been placed, your number in queue is #{@holdRequest.queuenumber}" }
            format.json { render :show, status: :created, location: @holdRequest }
          end
        else
          format.html { render :new }
          format.json { render json: @holdRequest.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def return
    @student = Student.find(params[:student_id])
    @book = Book.find(params[:book_id])
    #quantity = @book.quantity
    unless BookIssueHistory.where(:student_id => @student.id, :book_id => @book.id,:return_date  => nil).first.nil?
        @book_issue_history = BookIssueHistory.where(:student_id => @student.id, :book_id => @book.id,:return_date  => nil).first
        @book_issue_history.return_date = Date.today
        @book.increment(:quantity)
        @book.save!
        respond_to do |format|
          if @book_issue_history.save
            UserMailer.returnbook_email(@student,@book).deliver_now
            updateHoldRequests(@book)
            format.html { redirect_to :students, notice: 'Book successfully returned.' }
            format.json { render :show, status: :created, location: @book_issue_history }
          else
            format.html { render :new }
            format.json { render json: @book_issue_history.errors, status: :unprocessable_entity }
          end
        end
    else
      redirect_to :students, notice: 'Book not checked out.'
    end
  end

  def updateHoldRequests(book)
    @library = Library.where(id: book.library_id).first
    @approvedreqs = HoldRequest.where(book_id: book.id, approved: true ).order(:queuenumber)
    #puts @approvedreqs.first.queuenumber
    unless @approvedreqs.first.nil?
      qn = @approvedreqs.first.queuenumber
      student = Student.find(@approvedreqs.first.student_id)
      checkout_count = BookIssueHistory.where(:student_id => student.id,:return_date  => nil).count
      if book.quantity > 0 && checkout_count != student.max_books_borrowed
        issue_date = Date.today
        overdue_date = issue_date + (@library.max_days_borrowed).days
        @book_issue_history = BookIssueHistory.new
        @book_issue_history.book_id = book.id
        @book_issue_history.library_id = book.library_id
        @book_issue_history.student_id = student.id
        @book_issue_history.issue_date = issue_date
        @book_issue_history.overdue_date = overdue_date
        @book.decrement(:quantity)
        @book.save!
        @book_issue_history.save!
        UserMailer.checkout_email(student,book).deliver_now
        @approvedreqs.first.destroy!
        @reqs = HoldRequest.where(book_id: book.id)
        @reqs.each do |req|
          if req.queuenumber > qn
            req.queuenumber -= 1
          end
        end
      end
    end
  end
  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title,:isbn,:author,:language,:published,:edition,:cover_image,:subject,
                                   :library_id,:summary,:quantity,:special_collection)
    end
end
