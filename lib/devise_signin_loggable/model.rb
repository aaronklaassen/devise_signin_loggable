module Devise
  module Models
    module SigninLoggable
      def self.included(obj)
        Devise::Models.config(obj.class, :max_logged_signins_per_user,
                                         :remove_logged_signins_older_than)
      end
    end
  end
end