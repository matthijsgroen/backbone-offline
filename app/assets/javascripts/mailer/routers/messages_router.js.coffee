#= require mailer/views/message_list_view
#= require mailer/views/button_view
#= require mailer/views/compose_message_view

class OfflineMessenger.Routers.MessagesRouter extends Backbone.Router
  routes:
    '': 'index'
    'compose/new': 'composePost'

  initialize: ({ @collection }) ->
    @listView = new OfflineMessenger.Views.MessageListView { @collection }
    @addButton = new OfflineMessenger.Views.ButtonView
      label: 'Compose'

    @listenTo @addButton, 'click', @composePost
    @resourceReady = @collection.fetch()

  index: ->
    $('[data-content=posts]').append @addButton.render().el
    $('[data-content=posts]').append @listView.render().el

  composePost: ->
    @index()
    @resourceReady.then =>
      @navigate 'compose/new'
      model = @collection.add content: ''
      composeView = new OfflineMessenger.Views.ComposeMessageView { model }
      $('body').append composeView.render().el
      setTimeout(
        ->
          composeView.$('textarea').focus()
        10
      )

