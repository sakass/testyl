class CreateCalculations < ActiveRecord::Migration
  def self.up
    create_table :calculations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :calculations
  end
end
