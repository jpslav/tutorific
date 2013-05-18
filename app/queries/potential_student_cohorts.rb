class PotentialStudentCohorts

  def initialize(student)
    @student = student
    @relation = Cohort.where{section_id == @student.section_id}
    if @relation.empty?
      @relation = Cohort.joins{section}.where{section.klass_id == @student.section.klass_id}
    end
  end

  def smallest
    # Our first instinct was that since auditors are not part of the formal research 
    # study, they should not be members of cohorts.  However, this means their 
    # whole OST experience would be broken (because without a cohort, they are not 
    # linked to a learning condition).  So what we do below is assign them to cohorts 
    # as we would any normal registered student.  However, when we're assigning 
    # registered students to cohorts we do not count auditing students already in 
    # cohorts; this way the cohorts will continue to have equal numbers of registered 
    # students. While not totally required, for simplicity when adding auditors we also
    # don't  count registered students. We will also continue to not include auditing 
    # students in the research reports.

    smallest_cohort_size = @relation.collect{|c| c.students.active.same_kind_as(self).count}.min
    @relation.select{|c| c.students.active.same_kind_as(self).count == smallest_cohort_size}
  end

end