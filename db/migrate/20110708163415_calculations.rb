class Calculations < ActiveRecord::Migration
   def self.up
       create_table :calculations do |t|
          t.float :calc
	  t.integer :stock_id
       end
  end
  def self.down
      drop_table :calculations
  end
end