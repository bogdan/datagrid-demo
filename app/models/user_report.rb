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
  filter(:logins_count, :integer, :range => true, :default => proc { [User.minimum(:logins_count), User.maximum(:logins_count)]})
  filter(:registered_at, :date, :range => true)

  #
  # Columns
  #

  column(:id)
  column(:email, :url => proc {|user| "mailto:#{user.email}"})
  column(:registration_type) do |record|
    record.registration_type.humanize
  end
  column(:logins_count)
  column(:registered_at) do |record|
    record.registered_at.to_date
  end
  column(:disabled) do
    self.disabled? ? "Yes" : "No"
  end

end
