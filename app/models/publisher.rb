# == Schema Information
#
# Table name: publishers
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Publisher < ActiveRecord::Base
  has_many :events

  validates_presence_of :title, :url
  validates_uniqueness_of :title, :url
  validates_format_of :url, with: URI.regexp
end
