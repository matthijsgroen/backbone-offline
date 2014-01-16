

class OfflineSync

  constructor: ({ @backendSync }) ->

  syncList: ->
    JSON.parse(localStorage['toSync'] || '[]')

  fetchModelData: (method, model, options) ->
    url = _.result(model, 'url')
    defer = $.Deferred()
    if navigator.onLine
      #console.log 'data from backend'
      @backendSync(method, model).then (data) ->
        # Store the fetched result also in our local cache
        localStorage[url] = JSON.stringify(data)
        defer.resolveWith(this, [data])
    else
      #console.log 'data from cache'
      # Return the result from our local cache
      data = JSON.parse(localStorage[url])
      setTimeout(
        => defer.resolveWith(this, [data])
        0
      )
    defer.promise()

  updateDataWithSyncList: (data, url) ->
    # synchronize data with synclist
    for sync in @syncList()
      if sync.url is url
        data.push sync.data
    data

  processSyncList: ->
    return unless navigator.onLine

    for sync in @syncList()
      modelId = sync.data.id

      for collection in @offlineModels
        if model = collection.get?(modelId)
          model.set id: null
          @backendSync(sync.method, model, sync.options)
          localStorage['toSync'] = JSON.stringify []
          @trigger('update:syncList', this, [])

  offlineModels: []

  sync: (method, model, options) ->
    url = _.result(model, 'url')

    unless _.contains(@offlineModels, model)
      @offlineModels.push model

    if method is 'create'
      model.set id: 'ol1'

      data = model.toJSON()
      synclist = @syncList()

      synclist.push { url: url, data: data, method: method }
      localStorage['toSync'] = JSON.stringify synclist
      @trigger('update:syncList', this, synclist)

      defer = $.Deferred()
      setTimeout(
        => defer.resolveWith(this, [data])
        0
      )
      defer.promise().then (data) ->
        options.success(data)

    if method is 'read'
      @fetchModelData(method, model, options).then (data) =>
        data = @updateDataWithSyncList(data, url)
        options.success(data)
        @processSyncList()

_.extend OfflineSync::, Backbone.Events

Backbone.offlineSync = new OfflineSync
  backendSync: Backbone.sync

Backbone.sync = -> Backbone.offlineSync.sync(arguments...)
