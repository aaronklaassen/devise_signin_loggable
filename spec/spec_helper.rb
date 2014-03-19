require 'active_record'
require 'devise'
require 'shoulda'
require 'devise_signin_loggable'

RSpec.configure do |config|
  config.order = "random"

  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  ActiveRecord::Schema.define do
    self.verbose = false

    create_table :logged_signins do |t|
      
      t.references :resource, polymorphic: true
      t.string     :ip_address

      t.timestamps
    end
    
  end
end