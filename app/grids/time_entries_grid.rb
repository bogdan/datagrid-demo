class TimeEntriesGrid < ApplicationGrid

  #
  # Scope
  #

  scope do
    User.select(
      "users.name",
      "projects.name as project_name",
      "accounts.name as account_name",
      "sum(time_entries.hours) as report_hours"
    ).joins(
      time_entries: {project: :account}
    ).group("projects.name", "users.name", "accounts.name").
    order("users.name")
  end


  #
  # Filters
  #

  filter(
    :project_id, :enum,
    :select => :project_id_select,
    :multiple => true,
    :include_blank => false
  ) do |value|
    self.where(:time_entries => {:project_id => value})
  end


  filter(
    :year, :enum,
    :select => :year_select,
    :include_blank => false,
    :default => lambda {Date.today.year}
  ) do |value|
    self.where([
      "extract(year from time_entries.date) = ?",
      value.to_i
    ])
  end

  filter(
    :month, :enum,
    :select => :month_select,
    :include_blank => false,
    :default => lambda {Date.today.month}
  ) do |value|

    self.where([
      "extract(month from time_entries.date) = ?",
      value.to_i
    ])
  end


  #
  # Columns
  #

  column(:user_name, :header => "Developer", :order => "users.name") do
    self.name
  end
  column(:project_name, :header => "Project", :order => "projects.name")
  column(
    :account_name,
    :header => "Company",
    :order => "accounts.name",
  ) do |model|
    format(model.account_name) do
      render :partial => "time_entries/company", :locals => {:model => model}
    end
  end

  column(:report_hours, order: "sum(time_entries.hours)")

  protected

  def year_select
    TimeEntry.all.any? ? (TimeEntry.minimum(:date).year..TimeEntry.maximum(:date).year) : []
  end
  def month_select
    Date::MONTHNAMES[1..12].enum_for(:each_with_index).collect {|name, index| [name, index + 1]}
  end

  def project_id_select
    Project.all.map {|p| [p.name, p.id]}
  end
end
