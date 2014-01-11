
Backbone.backendSync = Backbone.sync

Backbone.sync = (method, model, options) ->
  url = _.result(model, 'url')

  synclist = JSON.parse(localStorage['toSync'] || '[]')

  if method is 'read'

    getData = (method, model, options) ->
      defer = $.Deferred()
      if navigator.onLine
        # Store the fetched result also in our local cache
        #console.log 'data from backend'
        Backbone.backendSync(method, model).then (data) ->
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

    getData(method, model, options).then (data) ->
      # synchronize data with synclist
      for sync in synclist
        if sync.url is url
          data.push sync.data

      options.success(data)

  else
    synclist.push { url: url, data: model.toJSON(), method: method }
    localStorage['toSync'] = JSON.stringify synclist

    #Backbone.backendSync(arguments...)
