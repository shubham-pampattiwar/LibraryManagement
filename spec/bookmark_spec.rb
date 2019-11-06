require 'rails_helper'

RSpec.describe Bookmark, :type => :model do
  it "is not valid without a book" do
    bookmark = Bookmark.new(book_id: nil)
    expect(bookmark).to_not be_valid
  end
  it "is not valid without a student" do
    bookmark = Bookmark.new(student_id: nil)
    expect(bookmark).to_not be_valid
  end
  it "is a valid bookmark" do
    bookmark = Bookmark.new(student_id: 1,book_id:2)
    expect(bookmark).to be_valid
  end
end