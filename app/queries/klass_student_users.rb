
class KlassStudentUsers

  def intialize(klass)
    @relation = User.joins{students}
                    .joins{students.section}
                    .where{students.section.klass_id == klass.id}
  end

  def includes?(user)
    @relation.where{user.id == my{user}.id}.any?
  end

end