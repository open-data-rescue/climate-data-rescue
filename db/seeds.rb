
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
unless User.any?
  User.create!(
    email: 'draw-dev-admin@grr.la',
    password: 'password',
    password_confirmation: 'password',
    display_name: 'Administrator',
    admin: true
  )
end

unless Rails.env.production?
  connection = ActiveRecord::Base.connection
  connection.tables.each do |table|
    connection.execute("TRUNCATE #{table}") unless table == "schema_migrations" || table == "users"
  end

  sql = File.read('docker/init-data/DRAW-init.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      Rails.logger.debug statement
      connection.execute(statement)
    end
  end
end
