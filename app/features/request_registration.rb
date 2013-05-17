
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

  def execute
    # Run validations 
    return if !self.valid?

    # Create pending student
    student = Student.create(user: @user, section: @section, is_auditing: @is_auditing)

    # Approve if preapproved
    if !@is_auditing && klass.is_preapproved?(@user) && (!klass.ended? || !Rails.env.production?)
      ApprovePendingStudent.new(student).execute
    else
      StudentMailer.registration_pending(student).deliver  # likely a notification engine call instead
    end
  end

  def klass
    @section.klass
  end

private

  def user_not_already_in_course
    errors.add(:base, "You have either already requested to join this class or you are in this class.") \
      if Query::is_user_in_klass?(@user, klass)
  end

  def researcher_not_registering
    errors.add(:base, 'You cannot register for this class because you are a system researcher.') \
      if !@is_auditing && Query::is_user_a_researcher?(@user)
  end
end