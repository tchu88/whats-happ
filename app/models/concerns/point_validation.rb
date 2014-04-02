module PointValidation
  extend ActiveSupport::Concern

  included do
    validates_presence_of :longitude
    validates_numericality_of :longitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180

    validates_presence_of :latitude
    validates_numericality_of :latitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180
  end
end
