require 'spec_helper'

describe Devise::Models::LoggedSignin do

  def create_logged_signin(user, weeks_old = 0)
    log = Devise::Models::LoggedSignin.new
    log.resource = user
    log.ip_address = "127.0.0.1"
    log.created_at = weeks_old.weeks.ago
    log.save!
    log
  end

  before :each do
    @user = User.create!
    9.times { |i| create_logged_signin(@user, i) }
    5.times { |i| create_logged_signin(User.create!, i) }
  end

  after :each do
    User.destroy_all
    Devise::Models::LoggedSignin.destroy_all
  end

  describe "associations" do
    it { should belong_to(:resource) }
  end

  describe "removing previous signins on creation" do

    context "devise is configured to remove old signins" do
      it "deletes logged signins that are too old" do
        @user.stub(:remove_logged_signins_older_than).and_return(4.weeks.ago)
        expect {
          create_logged_signin(@user)
        }.to change(Devise::Models::LoggedSignin, :count).by(-4)

        cutoff = @user.remove_logged_signins_older_than
        old = Devise::Models::LoggedSignin.where("resource_id = ? AND created_at <= ?", @user.id, cutoff)
        old.size.should be_zero
      end
    end

    context "devise is not configured to remove old signins" do
      it "does not delete any logged signins" do
        @user.stub(:remove_logged_signins_older_than).and_return(nil)
        expect {
          create_logged_signin(@user)
        }.to change(Devise::Models::LoggedSignin, :count).by(1)
      end
    end

    context "devise is configured to limit logged signins per user" do
      it "deletes logged signins when there are too many" do
        @user.stub(:max_logged_signins_per_user).and_return(7)
        create_logged_signin(@user)
        Devise::Models::LoggedSignin.by_resource(@user).count.should == 7
        Devise::Models::LoggedSignin.count.should == 12
      end

      it "deletes the oldest signins and keeps the newest ones" do
        @user.stub(:max_logged_signins_per_user).and_return(7)
        all_logins = Devise::Models::LoggedSignin.by_resource(@user).to_a
        new_log = create_logged_signin(@user)
        Devise::Models::LoggedSignin.by_resource(@user).should == all_logins.last(6) + [new_log]
      end
    end

    context "devise is not configured to limit logged signins" do
      it "does not delete any logged signins" do
        @user.stub(:max_logged_signins_per_user).and_return(nil)
        expect {
          create_logged_signin(@user)
        }.to change(Devise::Models::LoggedSignin, :count).by(1)
      end
    end

  end
end