
Backbone.backendSync = Backbone.sync

_.extend Backbone,
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

  updateDataWithSynchList: (data, url) ->
    # synchronize data with synclist
    for sync in @syncList()
      if sync.url is url
        data.push sync.data
    data

  processSyncList: ->
    return unless navigator.onLine

    for sync in @syncList()
      modelId = sync.data.id

      for collection in Backbone.offlineModels
        if model = collection.get?(modelId)
          model.set id: null
          Backbone.backendSync(sync.method, model, sync.options)
          localStorage['toSync'] = JSON.stringify []

  offlineModels: []

  sync: (method, model, options) ->
    url = _.result(model, 'url')

    unless _.contains(Backbone.offlineModels, model)
      Backbone.offlineModels.push model

    if method is 'create'
      model.set id: 'ol1'

      data = model.toJSON()
      synclist = Backbone.syncList()

      synclist.push { url: url, data: data, method: method }
      localStorage['toSync'] = JSON.stringify synclist

      defer = $.Deferred()
      setTimeout(
        => defer.resolveWith(this, [data])
        0
      )
      defer.promise().then (data) ->
        options.success(data)

    if method is 'read'
      Backbone.fetchModelData(method, model, options).then (data) ->
        data = Backbone.updateDataWithSynchList(data, url)
        options.success(data)
        Backbone.processSyncList()

