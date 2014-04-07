class Event < ActiveRecord::Base
  belongs_to :publisher

  include PointValidation
  validates_presence_of :message
  validates_uniqueness_of :message

  WITHIN = %{
    ST_DWithin(
      ST_GeographyFromText(
        'SRID=4326;POINT(' || events.longitude || ' ' || events.latitude || ')'
      ),
      ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
      %d
    )
  }.freeze

  def self.within(opts)
    where(WITHIN, opts.fetch(:longitude), opts.fetch(:latitude), opts.fetch(:radius))
  end

  def self.last_week
    where('created_at >= ?', 1.week.ago)
  end
end
