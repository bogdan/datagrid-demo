class Project < ActiveRecord::Base

  has_many :time_entries

  validates_presence_of :name
  validates_uniqueness_of :name
end
