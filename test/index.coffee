sinon = require 'sinon'
request = require 'superagent'
esa = require "#{process.env.PWD}/src"

httpMethods = [
  'get'
  'post'
  'put'
  'patch'
  'del'
]

requestStub = (name)->
  (url)->
    {
      name: name
      url: url

      _send: null
      send: (params)->
        @_send = params
        @

      _headers: []
      set: (header)->
        @_headers.push header

      end: (callback)->
        callback null,
          body: @
    }

describe 'esa',->

  sinonObjects = {}

  beforeEach ->
    sinonObjects = {}

  afterEach ->
    for key, sinonObjects of sinonObjects
      do sinonObjects.restore

  describe 'exec', ->

    httpMethods.forEach (method)->
      it "methodが #{method} であれば request.#{method} がコールされる", ->
        sinonObjects.request = sinon.stub request, method, requestStub(method)
        client = esa()
        client.exec method, 'urlString', (err, ret)->
          ret.body.name.should.equal method

    it "method がその他の値であれば request.get がコールされる", ->
      method = 'get'
      sinonObjects.request = sinon.stub request, method, requestStub(method)
      client = esa()
      client.exec 'otherMethod', 'urlString', (err, ret)->
        ret.body.name.should.equal method


