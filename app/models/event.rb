class Event < ActiveRecord::Base
  belongs_to :publisher

  include PointValidation
  validates_presence_of :message
end
