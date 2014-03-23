module Devise
  module Models
    class LoggedSignin < ::ActiveRecord::Base
      belongs_to :resource, polymorphic: true

      validates :resource, :ip_address, presence: true

      after_create :remove_old_signins

      scope :by_resource, lambda { |res| where(resource_id: res.id, resource_type: res.class.to_s) }

      private

      def remove_old_signins
        by_user = Devise::Models::LoggedSignin.by_resource(resource)

        min_date = resource.class.remove_logged_signins_older_than
        max_signins = resource.class.max_logged_signins_per_user

        by_user.where("created_at <= ?", min_date).destroy_all if min_date
        by_user.reverse_order.offset(max_signins).destroy_all if max_signins
      end
    end
  end
end