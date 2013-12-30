#= require mailer/templates/message_list

class OfflineMessenger.Views.MessageListView extends Backbone.View
  template: JST['mailer/templates/message_list']

  render: ->
    @$el.html @template
      messageCount: => @collection.length
    this



