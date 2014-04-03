class Event < ActiveRecord::Base
  belongs_to :publisher

  include PointValidation
  validates_presence_of :message
  validates_uniqueness_of :message
end
