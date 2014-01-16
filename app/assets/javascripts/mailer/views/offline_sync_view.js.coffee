#= require mailer/templates/offline_sync

class OfflineMessenger.Views.OfflineSyncView extends Backbone.View
  className: 'offline-status'
  template: JST['offline_sync']

  initialize: ->
    @listenTo Backbone.offlineSync, 'update:syncList', @render

  render: ->
    presenter =
      amountUnprocessed: Backbone.offlineSync.syncList().length
    @$el.html @template presenter
    this
