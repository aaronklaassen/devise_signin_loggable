require 'devise'
require 'devise_signin_loggable/logged_signin'

module Devise

  # By default, log everything.
  mattr_accessor :max_logged_signins_per_user
  @@max_signin_logs_per_user = nil

  mattr_accessor :remove_logged_signins_older_than
  @@remove_logged_signins_older_than = nil

end

Warden::Manager.after_authentication do |user,auth,opts|

  # This can't be the right way to do this.
  if user.class.ancestors.any? { |a| a.to_s.include?("SigninLoggable") }
  
    log = Devise::Models::LoggedSignin.new
    log.resource = user
    log.ip_address = auth.request.remote_ip
    log.save
  end
end

Devise.add_module(:signin_loggable, :model  => 'devise_signin_loggable/model')
