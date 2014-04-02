class Event < ActiveRecord::Base
  include PointValidation
  validates_presence_of :message
end
