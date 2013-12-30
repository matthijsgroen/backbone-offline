#= require mailer/templates/message_item

class OfflineMessenger.Views.MessageItemView extends Backbone.View
  template: JST['mailer/templates/message_item']
  tagName: 'li'

  render: ->
    presenter =
      content: @model.get('content')

    @$el.html @template presenter

    this
