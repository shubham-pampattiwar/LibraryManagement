class WelcomeController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to admins_path

    elsif librarian_signed_in?
      redirect_to librarians_path

    elsif student_signed_in?
      redirect_to students_path
    end
  end
end
