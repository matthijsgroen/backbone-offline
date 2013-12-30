class OfflineMessenger.Application

  constructor: ->
    @initialized = no

  initialize: ->
    return if @initialized
    world = {}

    # Event handlers will populate the world with model and collection instances
    @trigger 'application:setup', world

    # Event handlers will use the world objects to instantiate views and routers
    @trigger 'application:initialize', world

    $ =>
      @trigger 'application:ready', world
      Backbone.history?.start(pushState: yes) unless Backbone.History.started
      @initialized = yes

_.extend OfflineMessenger.Application::, Backbone.Events

OfflineMessenger.app = new OfflineMessenger.Application
