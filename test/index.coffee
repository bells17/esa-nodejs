sinon = require 'sinon'
request = require 'superagent'
querystring = require 'querystring'
esa = require "#{process.env.PWD}/src"

endpoint = 'https://api.esa.io'
baseScheme = '/v1/teams'

httpMethods = [
  'get'
  'post'
  'put'
  'patch'
  'del'
]

# request(superagent)用stub
requestStub = (name)->
  (url)->
    {
      name: name
      url: url

      _send: null
      send: (params)->
        @_send = params
        @

      _headers: {}
      set: (key, val)->
        @_headers[key] = val

      end: (callback)->
        callback null,
          body: @
    }

# esa().exec用stub
esaExecStub = (method, url, params, headers, callback)->
  unless headers
        headers = params
        params = {}

  unless callback
    callback = headers
    headers = {}

  callback null,
    method: method
    url: url
    params: params
    headers: headers


describe 'esa', ->

  sinonObjects = {}

  beforeEach ->
    sinonObjects = {}

  afterEach ->
    for key, sinonObjects of sinonObjects
      do sinonObjects.restore

  describe 'constructor', ->

    it 'esa(conf) の conf にセットした accessToken と team が esa(conf).accessToken と esa(conf).team になる', ->
      [
        {
          arg:
            accessToken: 'accessToken'
            team: 'team'
          expected:
            accessToken: 'accessToken'
            team: 'team'
        }
        {
          arg:
            accessToken: 'accessToken'
          expected:
            accessToken: 'accessToken'
            team: undefined
        }
        {
          arg:
            team: 'team'
          expected:
            accessToken: undefined
            team: 'team'
        }
        {
          arg: {}
          expected:
            accessToken: undefined
            team: undefined
        }
      ].forEach (val)->
        client = esa()
        Object.keys(val.expected).forEach (key)->
          if client[key]
            client[key].should.equal val.expected[key]

  describe 'url', ->
    
    it "withTeam == true であれば team の値を元にurl文字列が生成される", ->
      client = esa {team: 'teamstring'}
      client.url().should.equal "#{endpoint}#{baseScheme}/teamstring/"

    it "withTeam == false であれば team の値を元にせずurl文字列が生成される", ->
      client = esa {team: 'teamstring'}
      client.url(false).should.equal "#{endpoint}#{baseScheme}/"

  httpMethods.forEach (method)->
    describe "#{method}", ->
      it "esa().#{method} をコールすると esa().exec が引数 method が #{method} でコールされる", ->
        client = esa()
        sinonObjects.request = sinon.stub request, method, requestStub(method)
        sinon.stub client, 'exec', esaExecStub
        client[method] 'urlString', (err, ret)->
          ret.method.should.equal method

  describe 'exec', ->

    # request.[method]
    httpMethods.forEach (method)->
      it "method が #{method} であれば request.#{method} がコールされる", ->
        sinonObjects.request = sinon.stub request, method, requestStub(method)
        client = esa()
        client.exec method, 'urlString', (err, ret)->
          ret.body.name.should.equal method

    it 'method がその他の値であれば request.get がコールされる', ->
      method = 'get'
      sinonObjects.request = sinon.stub request, method, requestStub(method)
      client = esa()
      client.exec 'otherMethod', 'urlString', (err, ret)->
        ret.body.name.should.equal method

    # url
    httpMethods
      .filter (method)-> method isnt 'get'
      .forEach (method)->
        it "method が #{method} であれば url を引数に request.#{method} がコールされる", ->
          sinonObjects.request = sinon.stub request, method, requestStub(method)
          client = esa()
          [
            'urlString'
            'http://localhost'
            ''
            12345
            12345.6789
            true
            false
          ].forEach (val)->
            client.exec method, val, (err, ret)->
              ret.body.url.should.equal val

    it 'method が get であれば url に params をqueryパラメータに変換した文字列が追加されたを引数に request.get がコールされる', ->
      method = 'get'
      sinonObjects.request = sinon.stub request, method, requestStub(method)
      client = esa()
      params =
        param1key: 'param1val'
        param2key: 'param2val'
        param3key: 'param3val'
        param4key: 'param4val'

      client.exec 'get', 'urlString',  params, (err, ret)->
        url = ret.body.url.split '?'
        query = querystring.decode url[1]
        Object.keys(query)
          .filter (key)-> key isnt 'access_token'
          .forEach (key)->
            query[key].should.equal params[key]

    # params
    httpMethods
      .filter (method)-> method isnt 'get'
      .forEach (method)->
        it "method が #{method} であれば params を引数に request.#{method}().send がコールされる", ->
          sinonObjects.request = sinon.stub request, method, requestStub(method)
          client = esa()
          params =
            param1key: 'param1val'
            param2key: 'param2val'
            param3key: 'param3val'
            param4key: 'param4val'

          client.exec method, 'urlString', params, (err, ret)->
            Object.keys(ret.body._send)
              .filter (key)-> key isnt 'access_token'
              .forEach (key)->
                ret.body._send[key].should.equal params[key]

    # headers
    httpMethods.forEach (method)->
      it "method が #{method} であれば params を引数としてループ処理で request.#{method}().set がコールされる", ->
        sinonObjects.request = sinon.stub request, method, requestStub(method)
        client = esa()
        headers =
          header1key: 'header1val'
          header2key: 'header2val'
          header3key: 'header3val'
          header4key: 'header4val'

        client.exec method, 'urlString', {}, headers, (err, ret)->
          Object.keys(ret.body._headers)
            .filter (key)-> key isnt 'access_token'
            .forEach (key)->
              ret.body._headers[key].should.equal headers[key]

    # access_token
    httpMethods
      .filter (method)-> method isnt 'get'
      .forEach (method)->
        it "method が #{method} であれば params.access_token に client.access_token が追加されて request.#{method}().end がコールされる", ->
          sinonObjects.request = sinon.stub request, method, requestStub(method)
          client = esa()
          client.accessToken = 'access_token_string'
          client.exec method, 'urlString', (err, ret)->
            ret.body._send.access_token.should.equal 'access_token_string'
