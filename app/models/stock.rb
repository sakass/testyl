class Stock < ActiveRecord::Base
  has_many :calculation
  validates_presence_of :title, :price, :quantity, :percent, :years
  validates_numericality_of :price, :quantity, :percent, :years, :message=>"Error Message"
end
