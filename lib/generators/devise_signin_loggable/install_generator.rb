module DeviseSigninLoggable
  class InstallGenerator < Rails::Generators::Base
    
    source_root File.expand_path("../templates", __FILE__) 

    def create_default_devise_settings
      inject_into_file "config/initializers/devise.rb", default_devise_settings, :after => "Devise.setup do |config|\n"   
    end
    
    def copy_migration_file
      copy_file '20140319161305_create_logged_signins.rb', 'db/migrate/20140319161305_create_logged_signins.rb'
    end
    
    private
    
    def default_devise_settings
      settings = <<-eof
  # ==> Signin logging Configuration 
  # config.max_logged_signins_per_user = 50
  # config.remove_logged_signins_older_than = 3.months
  
      eof
     
      settings
    end
    
  end
end