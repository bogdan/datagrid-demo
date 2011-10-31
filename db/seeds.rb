
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

date_range = (1.year.ago.to_date..Date.today).to_a
projects = Project.all
10.times do
  User.transaction do
    u = User.new
    u.email = Faker::Internet.email
    u.name = Faker::Name.first_name + " "  + Faker::Name.last_name
    u.disabled = rand(10) > 5
    u.registration_type = User::REGISTRATION_TYPES.sample
    u.logins_count = rand(10)
    u.registered_at = rand(100).hours.ago
    u.save!
    1000.times do
      t = TimeEntry.new
      t.user = u
      t.project = projects.sample
      t.hours = rand(8) + 1
      t.date = date_range.sample
      t.save!
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
