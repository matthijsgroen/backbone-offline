#= require mailer/templates/compose_message

class OfflineMessenger.Views.ComposeMessageView extends Backbone.View
  className: 'mod-composer'
  tagName: 'section'
  template: JST['compose_message']
  events:
    'keyup textarea': 'updateText'

  render: ->
    @$el.html @template this
    this

  updateText: ->
    @model.set content: @$('textarea').val()
