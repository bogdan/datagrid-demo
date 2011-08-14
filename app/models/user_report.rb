class UserReport
  include Datagrid
  include ActiveModel::Naming

  scope do
    User
  end
  filter(:email, :string)
  filter(:disabled, :eboolean)
  filter(:registration_type, :enum, :select => User::REGISTRATION_TYPES)
  integer_range_filters(:logins_count)
  date_range_filters(:registered_at)


  column(:id)
  column(:email)
  column(:registration_type) do |record|
    record.registration_type.humanize
  end
  column(:logins_count)
  column(:registered_at)

end
