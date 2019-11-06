require 'rails_helper'

RSpec.describe Book, :type => :model do
  it "is not valid without a isbn" do
    book = Book.new(isbn: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a title" do
    book = Book.new(title: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a summary" do
    book = Book.new(summary: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without an author" do
    book = Book.new(author: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a subject" do
    book = Book.new(subject: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a cover image" do
    book = Book.new(cover_image: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a language specification" do
    book = Book.new(language: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without its quantity" do
    book = Book.new(quantity: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without edition" do
    book = Book.new(edition: nil)
    expect(book).to_not be_valid
  end
  it "is not valid without a library" do
    book = Book.new(library_id: nil)
    expect(book).to_not be_valid
  end
end