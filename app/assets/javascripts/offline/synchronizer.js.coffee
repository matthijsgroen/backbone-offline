
Backbone.backendSync = Backbone.sync

Backbone.sync = (method, model, options) ->
  url = _.result(model, 'url')
  if method is 'read'
    if navigator.onLine
      # Store the fetched result also in our local cache
      Backbone.backendSync(arguments...).then (data) ->
        localStorage[url] = JSON.stringify(data)
    else
      # Return the result from our local cache
      defer = $.Deferred()
      data = JSON.parse(localStorage[url])
      setTimeout(
        => defer.resolveWith(this, [data])
        0
      )
      defer.promise().then (data) ->
        options.success(data)
  else
    Backbone.backendSync(arguments...)
