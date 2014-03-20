require 'spec_helper'

describe DeviseSigninLoggable::LoggedSignin do

  def create_logged_signin(user, weeks_old = 0)
    log = DeviseSigninLoggable::LoggedSignin.new
    log.resource = user
    log.ip_address = "127.0.0.1"
    log.created_at = weeks_old.weeks.ago
    log.save!
    log
  end

  before :all do
    @user = User.create!
    9.times { |i| create_logged_signin(@user, i) }
  end

  describe "associations" do
    it { should belong_to(:resource) }
  end

  describe "removing previous signins on creation" do

    context "devise is configured to remove old signins" do
      it "deletes logged signins that are too old" do
        @user.stub(:remove_logged_signins_older_than).and_return(4.weeks)
        expect {
          create_logged_signin(@user)
        }.to change(DeviseSigninLoggable::LoggedSignin, :count).by(-5)

        cutoff = @user.remove_logged_signins_older_than
        old = DeviseSigninLoggable::LoggedSignin.where("created_at <= ?", cutoff)
        old.size.should be_zero
      end
    end

    context "devise is not configured to remove old signins" do
      it "does not delete any logged signins" do
        @user.stub(:remove_logged_signins_older_than).and_return(nil)
        expect {
          create_logged_signin(@user)
        }.to change(DeviseSigninLoggable::LoggedSignin, :count).by(1)
      end
    end

    context "devise is configured to limit logged signins per user" do
      it "deletes logged signins when there are too many" do
        @user.stub(:max_logged_signins_per_user).and_return(7)
        expect {
          create_logged_signin(@user)
        }.to change(DeviseSigninLoggable::LoggedSignin, :count).by(-3)
      end
    end

    context "devise is not configured to limit logged signins" do
      it "does not delete any logged signins" do
        @user.stub(:max_logged_signins_per_user).and_return(nil)
        expect {
          create_logged_signin(@user)
        }.to change(DeviseSigninLoggable::LoggedSignin, :count).by(1)
      end
    end

  end
end