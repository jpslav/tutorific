
class Student < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cohort
  belongs_to :section

  validates :section_id, :presence => true
  validates :user_id, :presence => true#, :uniqueness => {:scope => :cohort_id} # this part only sometimes or elsewhere

  module Behavior

    def assign_to_cohort
      # When a new student registers for a section, she will be added to the cohort with 
      # the fewest members.  If there is more than one cohort with the same number of 
      # fewest members, she will be randomly assigned to one of them.
      # 
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
          
      cohorts = section.cohorts
      cohorts = section.klass.cohorts if cohorts.empty?

      smallest_cohort_size = cohorts.collect{|c| c.students.active.same_kind_as(self).count}.min
      candidate_cohorts = cohorts.select{|c| c.students.active.same_kind_as(self).count == smallest_cohort_size}
      
      target_cohort = candidate_cohorts.sample
      self.cohort = target_cohort
    end

  end

  include Behavior

end