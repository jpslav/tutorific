
def unique_username(first_name, last_name)
  username = "#{first_name}#{last_name}"
  username = username[0,19] if username.length > 20
  username = username + "#{SecureRandom.hex(4)}"
  username.gsub(/[^A-Za-z\d_]/, '')
end

FactoryGirl.define do

  sequence (:unique_number) {|n| n}

  factory :organization do
    sequence(:name)     {|n| "AutoGen Organization Name #{n}"}
    default_time_zone   "Central Time (US & Canada)"
  end

  factory :course do
    sequence(:name)                 {|n| "AutoGen Course Name #{n}"}
    description                     Faker::Lorem::paragraphs(1).join
    sequence(:typically_offered)    {|n| "AutoGen Typically Offered #{n}"}
    organization
  end

  factory :cohort do
    klass
    sequence(:name)  {|n| "AutoGen Cohort #{n}"}
  end

  factory :klass do
    course
    open_date   Time.now - 1.week
    start_date  Time.now
    end_date    Time.now + 3.months
    close_date  Time.now + 3.months + 1.week
    time_zone   "Central Time (US & Canada)"
    # association :creator, factory: :user
  end

  factory :researcher do
    user
  end

  factory :section do
    klass
    name "Section #{Faker::Lorem.words(2).join(' ')}"
  end

  factory :student do
    section
    cohort
    user
    is_auditing false
  end

  factory :user do
    first_name              {Faker::Name::first_name + FactoryGirl.generate(:unique_number).to_s}
    last_name               {Faker::Name::last_name}
    username                {|u| unique_username(u.first_name, u.last_name)}
    email                   {|u| "#{u.username}@example.com"}
    is_administrator        false
    research_id             {SecureRandom.hex(20)}
    education_id             {SecureRandom.hex(20)}
    # password                "password"
    # password_confirmation   "password"
    # confirmed_at            {Time.now}
  end

  factory :educator do
    klass
    user
    is_instructor false
    is_teaching_assistant false
    is_grader false
  end

end