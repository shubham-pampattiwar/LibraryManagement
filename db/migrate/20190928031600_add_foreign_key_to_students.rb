class AddForeignKeyToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :university, index: true, foreign_key: true
  end
end
