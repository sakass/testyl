class Stocks < ActiveRecord::Migration
  def self.up
     create_table :stocks do |t|
        t.string     :title, :limit => 32, :null => false
        t.float      :price
        t.integer    :quantity
        t.float    :percent
	t.integer    :years
        t.timestamp  :created_at
     end
  end
  def self.down
    drop_table :stocks
  end
end
