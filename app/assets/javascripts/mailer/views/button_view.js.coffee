class OfflineMessenger.Views.ButtonView extends Backbone.View
  tagName: 'button'
  className: 'button'
  events:
    'click': -> @trigger 'click'

  initialize: ({ @label }) ->

  render: ->
    @$el.text @label
    this
