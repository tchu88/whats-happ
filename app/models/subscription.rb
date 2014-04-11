# == Schema Information
#
# Table name: subscriptions
#
#  id              :integer          not null, primary key
#  phone           :string(255)      not null
#  radius          :integer          not null
#  longitude       :decimal(9, 6)    not null
#  latitude        :decimal(9, 6)    not null
#  created_at      :datetime
#  updated_at      :datetime
#  format          :string(255)      default(""), not null
#  unsubscribed_at :datetime
#  publisher_id    :integer
#

class Subscription < ActiveRecord::Base
  FORMATS = %w(sms)

  include PointValidation
  validates_presence_of :phone, :radius, :format
  validates_numericality_of :radius, greater_than: 0
  validates_inclusion_of :format, in: FORMATS

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

  def self.active
    where(unsubscribed_at: nil)
  end

  def self.unsubscribe_number(phone)
    where(phone: normalize_phone_number(phone)).update_all(unsubscribed_at: Time.now)
  end

  def phone=(str)
    super self.class.normalize_phone_number(str)
  end

  # TODO: how can this process be improved?
  def self.normalize_phone_number(str)
    # strip non-digits
    str = str.gsub(/\D/,'')

    # add a leading 1 if the length is 10
    if str.length == 10
      str = '1'+str
    end

    str
  end
end
