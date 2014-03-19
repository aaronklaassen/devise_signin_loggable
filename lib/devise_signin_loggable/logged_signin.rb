module DeviseSigninLoggable
  class LoggedSignin < ::ActiveRecord::Base

    belongs_to :resource, polymorphic: true

    validates :resource, :ip_address, presence: true
  end
end