class CreateLoggedSignins < ActiveRecord::Migration
  def change
    create_table :logged_signins do |t|
      
      t.references :resource, polymorphic: true
      t.string     :ip_address
      t.boolean    :success

      t.timestamps
    end
  end
end
