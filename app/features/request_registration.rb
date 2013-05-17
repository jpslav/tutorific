
class RequestRegistration

  # Could probably get away with not using ActiveModel::Validations,
  # (e.g. we could put the validation code inline in 'execute'), but 
  # including it does let us use built-in validators which may be useful
  include ActiveModel::Validations

  validate :user_not_already_in_course
  validate :researcher_not_registering

  def initialize(user, section, is_auditing)
    @user = user
    @section = section
    @is_auditing = is_auditing
  end

  # A generic authorization method that could be used by any code (e.g.
  # controllers) that call this feature
  def can_be_performed_by?(user)
    user == @user
  end

  def execute()
    # Run validations 
    return if !self.valid?

    # Create pending student

    student = Student.new(@user, @section, @is_auditing)
    student.save

    # CreatePendingStudent.new(@user, @section, @is_auditing)
    # Student.create(:user_id => user_id, :section_id => section_id, 
    #                :is_auditing => is_auditing, :student_specified_id => student_specified_id)

    # How to handle observers? (email, etc)


    # Approve if preapproved

  end

private


  def user_not_already_in_course
    errors.add(:base, "You have either already requested to join this class or you are in this class.") \
      if Query::is_user_in_klass?(@user, @section.klass)
  end

  def researcher_not_registering
    errors.add(:base, 'You cannot register for this class because you are a system researcher.') \
      if !@is_auditing && true #Query::is_user_a_researcher(@user)
  end
end