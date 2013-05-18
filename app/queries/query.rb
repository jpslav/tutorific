# Ideally there'd be a way to put each query method in its own file and have
# them all accessible from here, but I can't figure that out at the moment.
# Or alternatively, each query method could be injected from the query
# that it delegates to.  And all this would work with Rails autoloading.
# Maybe there's some other way to organize these queries, but this is the
# general idea

# All of these queries would be separately unit tested, and those tests
# would use entries in the DB

# I bet my favorite metaprogramming guru sees a beautiful solution

module Query

  def self.is_user_in_klass?(user,klass)
    KlassStudentUsers.new(klass).includes?(user)
  end

  def self.is_user_a_researcher?(user)
    Researcher.any?{|r| r.user_id == user.id}
  end

end