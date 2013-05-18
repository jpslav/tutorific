
class KlassStudentUsers

  def initialize(klass)
    @relation = User.joins{students}
                    .joins{students.section}
                    .where{students.section.klass_id == klass.id}
  end

  def includes?(user)
    @relation.where{id == my{user}.id}.any?
  end

end