require 'spec_helper.rb'

describe KlassStudentUsers do
  
  it "works" do
    section1 = FactoryGirl.create(:section)
    klass_a = section1.klass
    section2 = FactoryGirl.create(:section, :klass => klass_a)
    student1 = FactoryGirl.create(:student, :section => section1)
    student2 = FactoryGirl.create(:student, :section => section2)
    
    other_random_student = FactoryGirl.create(:student)
    klass_b = other_random_student.section.klass

    user1 = student1.user
    user2 = student2.user
    other_random_user = other_random_student.user

    KlassStudentUsers.new(klass_a).includes?(user1).should == true
    KlassStudentUsers.new(klass_a).includes?(user2).should == true
    KlassStudentUsers.new(klass_a).includes?(other_random_user).should == false
    KlassStudentUsers.new(klass_b).includes?(other_random_user).should == true

    Query::is_user_in_klass?(user1,klass_a).should == true
    Query::is_user_in_klass?(user1,klass_b).should == false
  end

end