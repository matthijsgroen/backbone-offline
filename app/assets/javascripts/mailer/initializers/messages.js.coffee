#= require mailer/routers/messages_router

OfflineMessenger.app.on 'application:setup', (world) ->
  world.messages = new Backbone.Collection
  world.messages.url = '/api/messages'

OfflineMessenger.app.on 'application:ready', (world) ->

  new OfflineMessenger.Routers.MessagesRouter
    collection: world.messages

