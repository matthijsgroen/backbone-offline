#= require mailer/templates/compose_message

class OfflineMessenger.Views.ComposeMessageView extends Backbone.View
  className: 'mod-composer'
  tagName: 'section'
  template: JST['compose_message']
  events:
    'keyup textarea': 'updateText'
    'click button.save': 'storeContent'
    'click button.cancel': 'closeView'

  render: ->
    @$el.html @template this
    this

  updateText: ->
    @model.set content: @$('textarea').val()

  storeContent: ->
    @trigger 'save', this

  closeView: ->
    @trigger 'close', this
