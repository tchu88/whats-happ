class Subscription < ActiveRecord::Base
  include PointValidation
  validates_presence_of :phone, :radius
  validates_numericality_of :radius, greater_than: 0

  attr_accessor :address

  CONTAINS = %{
    ST_DWithin(
      ST_GeographyFromText(
        'SRID=4326;POINT(' || subscriptions.longitude || ' ' || subscriptions.latitude || ')'
      ),
      ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
      subscriptions.radius
    )
  }.freeze

  def self.contains(opts)
    where(CONTAINS, opts.fetch(:longitude), opts.fetch(:latitude))
  end
end
