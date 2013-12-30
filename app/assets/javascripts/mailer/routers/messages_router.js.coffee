#= require mailer/views/message_list_view

class OfflineMessenger.Routers.MessagesRouter extends Backbone.Router
  routes:
    '': 'index'

  initialize: ({ @collection }) ->

  index: ->
    @collection.fetch()
    view = new OfflineMessenger.Views.MessageListView { @collection }
    $('body').append(view.render().el)

