class ApprovePendingStudent

  def initialize(student)
    @student = student
  end

  def execute
    @student.is_pending = false
    AssignStudentToCohort.new(@student).execute
    @student.save
  end

end