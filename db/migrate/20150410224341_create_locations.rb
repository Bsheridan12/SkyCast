class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :city
    	t.string :state
    	t.string :country
      t.string :zip
      t.string :formatted_address

    	t.decimal :latitude
    	t.decimal :longitude
    	
      t.timestamps null: false
    end
  end
end
