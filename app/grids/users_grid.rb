class UsersGrid < ApplicationGrid

  #
  # Scope
  #

  scope do
    User
  end

  #
  # Filters
  #

  filter(:id, :string, multiple: ',')
  filter(:email, :string)
  filter(:disabled, :xboolean)
  filter(:registration_type, :enum, select: User::REGISTRATION_TYPES.map {|r| [r.humanize, r]})
  filter(
    :logins_count, :integer,
    range: true,
    default: proc { User.minimum(:logins_count)..User.maximum(:logins_count)},
  )
  filter(:registered_at, :date, range: true)
  filter(:condition, :dynamic, header: "Dynamic condition")
  column_names_filter(header: "Extra Columns", checkboxes: true)

  #
  # Columns
  #

  column(:id, mandatory: true)
  column(:email, mandatory: true) do |model|
    format(model.email) do |value|
      link_to value, "mailto:#{value}", class: 'link', target: '_blank'
    end
  end
  column(:name, mandatory: true)
  column(:disabled, mandatory: true) do
    disabled? ? "Yes" : "No"
  end

  column(:registration_type) do |record|
    record.registration_type.humanize
  end
  column(:logins_count)
  column(:registered_at) do |record|
    format(record.registered_at.to_date) do |value|
      value.strftime("%b %d, %Y")
    end
  end
  column(:age, header: "Registration Age") do |record|
    age = (DateTime.now.in_time_zone - record.registered_at) / 1.day
    "#{age.to_i} days"
  end

  column(:actions, html: true, mandatory: true) do |record|
    link_to "Delete", "javascript:alert('Oh common! This is a demo.')", class: 'btn btn-primary'
  end
end
