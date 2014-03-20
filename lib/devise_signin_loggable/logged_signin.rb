module DeviseSigninLoggable
  class LoggedSignin < ::ActiveRecord::Base
    belongs_to :resource, polymorphic: true

    validates :resource, :ip_address, presence: true

    after_create :remove_old_signins

    scope :by_resource, lambda { |res| where(resource_id: res.id, resource_type: res.class.to_s) }

    private

    def remove_old_signins

      belonging_to_user = DeviseSigninLoggable::LoggedSignin.by_resource(resource)

      if resource.remove_logged_signins_older_than
        belonging_to_user.where("created_at <= ?", resource.remove_logged_signins_older_than).destroy_all
      end

      if resource.max_logged_signins_per_user
        belonging_to_user.offset(resource.max_logged_signins_per_user).destroy_all
      end
    end
  end
end