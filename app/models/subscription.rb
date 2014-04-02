class Subscription < ActiveRecord::Base
  include PointValidation
  validates_presence_of :phone, :radius
  validates_numericality_of :radius, greater_than: 0
end
