#= require mailer/templates/message_item

class OfflineMessenger.Views.MessageItemView extends Backbone.View
  template: JST['mailer/templates/message_item']
  tagName: 'li'
  className: 'mod-post'

  render: ->
    @$el.toggleClass('is-new', @model.isNew())
    presenter =
      content: marked @model.get('content')
    @$el.html @template presenter
    this
