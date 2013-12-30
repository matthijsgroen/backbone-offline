# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Message.create(content: <<-MESSAGE_CONTENT.strip_heredoc)
  here we will test the following capabilities of HTML 5:

  - Reaching a page without internet connection
  - Do an AJAX call from Backbone.js when offline
  - Submit data to the server when offline
  - Update the application cache when the connection is restored
  - look at various ways to do conflict resolvement

 MESSAGE_CONTENT
