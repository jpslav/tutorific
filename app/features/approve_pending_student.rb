class ApprovePendingStudent

  def initialize(student)
    @student = student
  end

  def execute
    @student.is_pending = false
    AssignStudentToCohort.new(@student).execute
    @student.save # ideally wouldn't save here but somewhere that called this feature
    NotificationEngine.notify(:registration_approved, student)
  end

end