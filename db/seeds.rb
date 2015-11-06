ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end

user = User.find_by_email('admin@test.com')
unless user
  user = User.new(name: 'Administrator', email: 'admin@test.com', password: 'password123', admin: true)
  user.save!
end