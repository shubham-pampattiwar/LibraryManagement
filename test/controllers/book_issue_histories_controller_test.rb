require 'test_helper'

class BookIssueHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_issue_history = book_issue_histories(:one)
  end

  test "should get index" do
    get book_issue_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_book_issue_history_url
    assert_response :success
  end

  test "should create book_issue_history" do
    assert_difference('BookIssueHistory.count') do
      post book_issue_histories_url, params: { book_issue_history: { issue_date: @book_issue_history.issue_date, overdue_date: @book_issue_history.overdue_date, return_date: @book_issue_history.return_date } }
    end

    assert_redirected_to book_issue_history_url(BookIssueHistory.last)
  end

  test "should show book_issue_history" do
    get book_issue_history_url(@book_issue_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_issue_history_url(@book_issue_history)
    assert_response :success
  end

  test "should update book_issue_history" do
    patch book_issue_history_url(@book_issue_history), params: { book_issue_history: { issue_date: @book_issue_history.issue_date, overdue_date: @book_issue_history.overdue_date, return_date: @book_issue_history.return_date } }
    assert_redirected_to book_issue_history_url(@book_issue_history)
  end

  test "should destroy book_issue_history" do
    assert_difference('BookIssueHistory.count', -1) do
      delete book_issue_history_url(@book_issue_history)
    end

    assert_redirected_to book_issue_histories_url
  end
end
