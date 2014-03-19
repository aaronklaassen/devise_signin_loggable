require 'spec_helper'

describe DeviseSigninLoggable::LoggedSignin do
  
  describe "associations" do
    it { should belong_to(:resource) }
  end

end