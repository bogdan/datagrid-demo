class Project < ActiveRecord::Base

  belongs_to :account
  has_many :time_entries

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :account
end
