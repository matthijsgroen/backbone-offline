#= require mailer/templates/message_list
#= require ./message_item_view

class OfflineMessenger.Views.MessageListView extends Backbone.View
  template: JST['mailer/templates/message_list']
  tagName: 'section'

  initialize: ->
    @listenTo @collection, 'add remove', @updateCounter
    @listenTo @collection, 'add', @addView

  render: ->
    presenter =
      messageCount: @collection.length

    @$el.html @template presenter
    this

  updateCounter: ->
    @$('h1').html I18n.t('messages.header', count: @collection.length)

  addView: (model) ->
    view = new OfflineMessenger.Views.MessageItemView { model }
    @$('ol').append view.render().el

