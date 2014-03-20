module DeviseSigninLoggable
  class LoggedSignin < ::ActiveRecord::Base

    belongs_to :resource, polymorphic: true

    validates :resource, :ip_address, presence: true

    after_create :remove_old_signins

    private

    def remove_old_signins
      
    end
  end
end