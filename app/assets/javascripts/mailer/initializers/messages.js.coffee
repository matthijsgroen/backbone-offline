#= require mailer/routers/messages_router

OfflineMessenger.app.on 'application:setup', (world) ->
  world.messages = new (class extends Backbone.Collection
    url: '/api/messages'
  )

OfflineMessenger.app.on 'application:initialize', (world) ->

  new OfflineMessenger.Routers.MessagesRouter
    collection: world.messages

