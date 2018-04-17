
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
User.create!(
  email: 'change@me.com',
  password: 'password',
  password_confirmation: 'password',
  display_name: 'Administrator',
  admin: true
)
