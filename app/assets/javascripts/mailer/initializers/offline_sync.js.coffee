#= require mailer/views/offline_sync_view
#
OfflineMessenger.app.on 'application:setup', (world) ->
  world.offlineSyncView = new OfflineMessenger.Views.OfflineSyncView

OfflineMessenger.app.on 'application:ready', (world) ->
  $('body').append world.offlineSyncView.render().el
