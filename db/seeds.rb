DatabaseCleaner.clean_with(:truncation)

Project.transaction do
  ["Google", "Apple", "Microsoft"].each do |name|
    Account.create!(:name => name)
  end
end

accounts = Account.all
Project.transaction do
  10.times do
    Project.create!({
      :account => accounts.sample,
      :name => Faker::Lorem.words(3).join(" ")
    })
  end
end

date_range = (Date.today.beginning_of_year.to_date..5.years.from_now.end_of_year.to_date).to_a
projects = Project.all
100.times do
  User.transaction do
    u = User.new
    u.email = Faker::Internet.email
    u.name = Faker::Name.first_name + " "  + Faker::Name.last_name
    u.disabled = rand(10) > 5
    u.registration_type = User::REGISTRATION_TYPES.sample
    u.logins_count = rand(10)
    u.registered_at = rand(100).hours.ago
    u.save!
    10.times do
      insertion = 1000.times.map { "(#{u.id}, #{projects.sample.id}, #{rand(8) + 1}, '#{date_range.sample}') " }.join(", ")
      TimeEntry.connection.execute <<-SQL
      insert into time_entries (user_id, project_id, hours, date) values
      #{insertion}
SQL
    end
  end
end


50.times do
  d = Document.new
  d.title = Faker::Lorem.sentence
  d.author = Faker::Internet.email
  d.body = Faker::Lorem.sentences(5).join(" ")
  d.rating = (0..10).to_a.sample

  d.save!

end
