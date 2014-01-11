#= require mailer/templates/message_list
#= require ./message_item_view

class OfflineMessenger.Views.MessageListView extends Backbone.View
  template: JST['message_list']
  tagName: 'section'
  className: 'mod-posts'

  initialize: ->
    @listenTo @collection, 'add remove', @updateCounter
    @listenTo @collection, 'add', @addView
    @listenTo @collection, 'remove', @removeView
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

  removeView: (model) ->
    updatedViews = []
    for view in @itemViews
      if view.model is model
        view.remove()
      else
        updatedViews.push view
    @itemViews = updatedViews


