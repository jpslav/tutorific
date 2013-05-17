module IsUserInKlass
  def self.is_user_in_klass?(user,klass)
    user.students.any?{|s| s.section.klass_id == klass.id}
  end
end



