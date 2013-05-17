require "spec_helper"

describe StudentMailer do
  describe "registration_pending" do
    let(:mail) { StudentMailer.registration_pending }

    it "renders the headers" do
      pending "TODO"
      # mail.subject.should eq("Registration pending")
      # mail.to.should eq(["to@example.org"])
      # mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      pending "TODO"
      # mail.body.encoded.should match("Hi")
    end
  end

  describe "registration_approved" do
    let(:mail) { StudentMailer.registration_approved }

    it "renders the headers" do
      pending "TODO"
      # mail.subject.should eq("Registration approved")
      # mail.to.should eq(["to@example.org"])
      # mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      pending "TODO"
      # mail.body.encoded.should match("Hi")
    end
  end

  describe "registration_rejected" do
    let(:mail) { StudentMailer.registration_rejected }

    it "renders the headers" do
      pending "TODO"
      # mail.subject.should eq("Registration rejected")
      # mail.to.should eq(["to@example.org"])
      # mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      pending "TODO"
      # mail.body.encoded.should match("Hi")
    end
  end

end
