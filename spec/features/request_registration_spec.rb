require 'spec_helper.rb'

describe RequestRegistration do
  
  it "automatically approves preapproved students" do
    pending("TODO")
  end

  it "fails when student is already in class" do
    user = double("User")
    section = double("Section", :klass => double("Klass"))
    Query.stub(:is_user_in_klass?).and_return(true)

    [true, false].each do |is_auditing|
      RequestRegistration.new(user, section, is_auditing).valid?.should be false
    end
  end


end