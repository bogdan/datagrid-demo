class AddIndexesToTimeEntries < ActiveRecord::Migration
  def change
    execute <<-s
create index date_year on time_entries (extract(year from date))
s
    execute <<-s
create index date_month on time_entries (extract(month from date))
s
  end
end
