require 'devise_signin_loggable/logged_signin'

module DeviseSigninLoggable

  Warden::Manager.after_authentication do |user,auth,opts|
    log = DeviseSigninLoggable::LoggedSignin.new
    log.resource = user
    log.ip_address = auth.request.remote_ip
    
    if log.save
      # TODO remove expired, etc logins
    end
  end


end
