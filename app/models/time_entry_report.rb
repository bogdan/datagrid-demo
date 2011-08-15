class TimeEntryReport

  include Datagrid


  #
  # Scope
  #
  
  scope do
    User.select(
      "users.*, projects.name project_name, accounts.name account_name, sum(time_entries.hours) report_hours"
    ).joins(:time_entries => {:project => :account}).group("projects.id", "users.id")

  end


  #
  # Filters
  #
  
  filter :project_id, :enum, :select => lambda {Project.all.map {|p| [p.name, p.id]}} do |value|
    self.where(["time_entries.project_id = ?", value])
  end


  filter :year, :enum, :select => lambda { (2010..Date.today.year)}, :include_blank => false, :default => Date.today.year do |value|
    self.where(["strftime('%Y', time_entries.date) = ?", value])
  end

  filter(:month, :enum, 
         :select => Date::MONTHNAMES[1..12].enum_for(:each_with_index).collect {|name, index| [name, index]},
         :include_blank => false,
         :default => proc { Date.today.month}
        ) do |value|
    self.where(["cast(strftime('%m', time_entries.date) as integer) = ?", value.to_i])
  end


  #
  # Columns
  #
  
  column(:user_name, :header => "Developer", :order => "users.name") do 
    self.name
  end
  column(:project_name, :header => "Project", :order => "projects.name")
  column(:account_name, :header => "Company", :order => "accounts.name")
  column(:report_hours)
end
