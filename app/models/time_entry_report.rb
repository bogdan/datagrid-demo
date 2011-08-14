class TimeEntryReport

  include Datagrid

  scope do
    User.select(
      "users.*, projects.name project_name, sum(time_entries.hours) report_hours"
    ).joins(:time_entries => :project)

  end
  filter :project_id, :select => lambda {Project.all.map {|p| [p.name, p.id]}} 
    #lambda cause Datagird to always recalculate select options, so that new Projects will appear
  filter :group_by_project, :boolean, :allow_blank => true do |value|
    raise 'hz'
    self.group(value ? "project_id" : "time_entries.id")
  end

  column(:user_name) do 
    self.name
  end
  column(:project_name)
  column(:report_hours)
end
