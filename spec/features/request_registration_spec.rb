require 'spec_helper.rb'

describe RequestRegistration do
  
  it "automatically approves preapproved students" do
    pending "TODO"
  end

  it "fails when student is already in class" do
    user = double("User")
    section = double("Section", :klass => double("Klass"))
    Query.stub(:is_user_in_klass?).and_return(true)

    [true, false].each do |is_auditing|
      RequestRegistration.new(user, section, is_auditing).valid?.should be false
    end
  end

  it "fails when user is a researcher and not auditing" do
    pending "TODO"
  end

  it "succeeds under normal conditions" do
    user = mock_model("User")
    klass = mock_model("Klass")
    klass.stub(:is_preapproved?) { false }
    section = mock_model("Section")

    Query.stub(:is_user_in_klass?).and_return(false)
    Query.stub(:is_user_a_researcher?).and_return(false)
    
    Student.stub(:save).and_return(true)

    rr = RequestRegistration.new(user, section, false)
    rr.stub(:klass) {klass}
    NotificationEngine.should_receive(:notify)
                      .with(:registration_pending, an_instance_of(Student))
    rr.execute
  end

end