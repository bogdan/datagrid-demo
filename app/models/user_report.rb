class UserReport
  include Datagrid

  #
  # Scope
  #
  
  scope do
    User
  end

  #
  # Filters
  #
  
  filter(:email, :string)
  filter(:disabled, :eboolean)
  filter(:registration_type, :enum, :select => User::REGISTRATION_TYPES.map {|r| [r.humanize, r]})
  integer_range_filters(:logins_count, {:default => proc { User.minimum(:logins_count)}}, {:default => proc {User.maximum(:logins_count)}})
  date_range_filters(:registered_at)

  #
  # Columns
  #

  column(:id)
  column(:email, :url => proc {|user| "mailto:#{user.email}"})
  column(:registration_type) do |record|
    record.registration_type.humanize
  end
  column(:logins_count)
  column(:registered_at)
  column(:disabled) do
    self.disabled? ? "Yes" : "No"
  end

end
