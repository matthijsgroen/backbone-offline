#= require mailer/templates/message_list
#= require ./message_item_view

class OfflineMessenger.Views.MessageListView extends Backbone.View
  template: JST['mailer/templates/message_list']
  tagName: 'section'
  className: 'mod-posts'

  initialize: ->
    @listenTo @collection, 'add remove', @updateCounter
    @listenTo @collection, 'add', @addView
    @itemViews = []

  render: ->
    presenter =
      messageCount: @collection.length
    @$el.html @template presenter

    elements = (view.render().el for view in @itemViews)
    @$('ol').append elements
    this

  remove: ->
    view.remove() for view in @itemViews
    super

  updateCounter: ->
    @$('h1').html I18n.t('messages.header', count: @collection.length)

  addView: (model) ->
    view = new OfflineMessenger.Views.MessageItemView { model }
    @itemViews.push view
    @$('ol').append view.render().el

