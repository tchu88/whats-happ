# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  message      :string(255)      not null
#  longitude    :decimal(9, 6)    not null
#  latitude     :decimal(9, 6)    not null
#  created_at   :datetime
#  updated_at   :datetime
#  publisher_id :integer
#

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

  scope :within, ->(opts){ where(WITHIN, opts.fetch(:longitude), opts.fetch(:latitude), opts.fetch(:radius)) }
  scope :recent, ->{ where('created_at >= ?', 1.day.ago) }
end
