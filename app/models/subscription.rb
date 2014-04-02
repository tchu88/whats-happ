class Subscription < ActiveRecord::Base
  validates_presence_of :phone, :radius, :latitude, :longitude
  validates_numericality_of :radius, greater_than: 0
  validates_numericality_of :longitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180
  validates_numericality_of :latitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180
end
