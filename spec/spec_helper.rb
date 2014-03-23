require 'active_record'
require 'shoulda'
require 'pry'
require 'devise_signin_loggable'

RSpec.configure do |config|
  config.order = "random"

  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  ActiveRecord::Schema.define do
    self.verbose = false

    # See the generator migration.
    create_table :logged_signins do |t|
      
      t.references :resource, polymorphic: true
      t.string     :ip_address

      t.timestamps
    end

    # A stub for the specs.
    create_table :users do |t|
    end
    
  end
end

class User < ActiveRecord::Base;
  def self.remove_logged_signins_older_than; end
  def self.max_logged_signins_per_user; end
end