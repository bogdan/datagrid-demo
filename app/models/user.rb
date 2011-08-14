class User < ActiveRecord::Base

  REGISTRATION_TYPES = ["LINKED_IN", "FACEBOOK", "DATAGRID_DEMO"]

  has_many :time_entries

  validates_presence_of :name, :email, :registered_at 
  validates_inclusion_of :registration_type, :in => REGISTRATION_TYPES
end
