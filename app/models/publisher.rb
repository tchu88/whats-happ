class Publisher < ActiveRecord::Base
  has_many :events

  validates_presence_of :title, :url
  validates_uniqueness_of :title, :url
  validates_format_of :url, with: URI.regexp
end
