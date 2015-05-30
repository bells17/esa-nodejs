querystring = require 'querystring'
request = require 'superagent'

api = require './api'

endpoint = 'https://api.esa.io'
baseScheme = '/v1/teams'

httpMethods = [
  'get'
  'post'
  'put'
  'patch'
  'del'
]

module.exports = (conf = {})->
  {
    accessToken
    team
  } = conf

  client = {
    endpoint: endpoint
    baseScheme: baseScheme
    accessToken: accessToken
    team: team

    url: (withTeam = true)->
      team = if withTeam then "/#{@team}" else ''
      "#{@endpoint}#{@baseScheme}#{team}/"

    get: (url, params, headers, callback)->
      @exec 'get', url, params, headers, callback

    post: (url, params, headers, callback)->
      @exec 'post', url, params, headers, callback

    put: (url, params, headers, callback)->
      @exec 'put', url, params, headers, callback

    patch: (url, params, headers, callback)->
      @exec 'patch', url, params, headers, callback

    del: (url, params, headers, callback)->
      @exec 'del', url, params, headers, callback

    exec: (method, url, params, headers, callback)->
      unless headers
        headers = params
        params = {}

      unless callback
        callback = headers
        headers = {}

      method = if method in httpMethods then method else 'get'
      params.access_token = @accessToken
      url += "?#{querystring.stringify params}" if method is 'get'
      req = request[method](url)
      req = req.send(params) if method isnt 'get'

      keys = Object.keys headers
      if keys.length isnt 0
        keys.forEach (key)->
          req.set key, headers[key]

      req.end callback

  }

  client.api = api(client)

  return client
