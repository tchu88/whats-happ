class Event < ActiveRecord::Base
  validates_presence_of :message, :longitude, :latitude
  validates_numericality_of :longitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180
  validates_numericality_of :latitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180
end
