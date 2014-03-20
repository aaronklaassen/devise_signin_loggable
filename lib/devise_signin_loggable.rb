require 'devise'
require 'devise_signin_loggable/logged_signin'

module DeviseSigninLoggable

  Warden::Manager.after_authentication do |user,auth,opts|
    log = DeviseSigninLoggable::LoggedSignin.new
    log.resource = user
    log.ip_address = auth.request.remote_ip
    log.save
  end


end
