class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  def addbookmark
    if Bookmark.where(student_id: current_student.id, book_id: params[:id]).first
       redirect_to :students, notice: 'Bookmark already exists'
    else
      @bookmark = Bookmark.new
      @bookmark.student_id = current_student.id
      @bookmark.book_id = params[:id]
      @user = current_student
      @book = Book.find(params[:id])
      respond_to do |format|
        if @bookmark.save
          UserMailer.bookmark_email(@user,@book).deliver_now
          format.html { redirect_to :students, notice: 'Bookmark was successfully created.' }
          format.json { render :show, status: :created, location: @bookmark }
        else
          format.html { render :new }
          format.json { render json: @bookmark.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def unbookmark
    if Bookmark.where(student_id: current_student.id, book_id: params[:id]).first
      @bookmark = Bookmark.where(student_id: current_student.id, book_id: params[:id]).first
      respond_to do |format|
        if @bookmark.destroy
          format.html { redirect_to :students, notice: 'Bookmark was successfully destroyed.' }
          format.json { head :no_content }
        else
          format.html { render :new }
          format.json { render json: @bookmark.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :students, notice: 'This Book is not bookmarked yet'

    end
  end

  def showbookmarks
    @bookmarked_books = []
    @bookmarks = Bookmark.where(student_id: current_student.id)
    @bookmarks.each do  |bookmark|
      @bookmarked_books << Book.where('id = ?',bookmark.book_id) 
    end
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      #params.fetch(:bookmark, {:book_id, :student_id})
      params.require(:bookmark).permit(:book_id, :student_id)
    end
end
