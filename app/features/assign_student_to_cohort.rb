class AssignStudentToCohort

  def initialize(student)
    @student
  end

  def execute
    # When a new student registers for a section, she will be added to the cohort with 
    # the fewest members.  If there is more than one cohort with the same number of 
    # fewest members, she will be randomly assigned to one of them.

    @student.cohort = PotentialStudentCohorts.new(@student).smallest.sample
    @student.save
  end

end