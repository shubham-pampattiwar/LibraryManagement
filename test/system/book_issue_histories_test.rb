require "application_system_test_case"

class BookIssueHistoriesTest < ApplicationSystemTestCase
  setup do
    @book_issue_history = book_issue_histories(:one)
  end

  test "visiting the index" do
    visit book_issue_histories_url
    assert_selector "h1", text: "Book Issue Histories"
  end

  test "creating a Book issue history" do
    visit book_issue_histories_url
    click_on "New Book Issue History"

    fill_in "Issue date", with: @book_issue_history.issue_date
    fill_in "Overdue date", with: @book_issue_history.overdue_date
    fill_in "Return date", with: @book_issue_history.return_date
    click_on "Create Book issue history"

    assert_text "Book issue history was successfully created"
    click_on "Back"
  end

  test "updating a Book issue history" do
    visit book_issue_histories_url
    click_on "Edit", match: :first

    fill_in "Issue date", with: @book_issue_history.issue_date
    fill_in "Overdue date", with: @book_issue_history.overdue_date
    fill_in "Return date", with: @book_issue_history.return_date
    click_on "Update Book issue history"

    assert_text "Book issue history was successfully updated"
    click_on "Back"
  end

  test "destroying a Book issue history" do
    visit book_issue_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Book issue history was successfully destroyed"
  end
end
