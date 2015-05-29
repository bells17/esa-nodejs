(function() {
  var api, baseScheme, endpoint, httpMethods, querystring, request,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  querystring = require('querystring');

  request = require('superagent');

  api = require('./api');

  endpoint = 'https://api.esa.io';

  baseScheme = '/v1/teams';

  httpMethods = ['get', 'post', 'put', 'patch', 'del'];

  module.exports = function(conf) {
    var accessToken, client, team;
    if (conf == null) {
      conf = {};
    }
    accessToken = conf.accessToken, team = conf.team;
    client = {
      endpoint: endpoint,
      baseScheme: baseScheme,
      accessToken: accessToken,
      team: team,
      url: function(withTeam) {
        if (withTeam == null) {
          withTeam = true;
        }
        team = withTeam ? "/" + this.team : '';
        return "" + this.endpoint + this.baseScheme + team + "/";
      },
      get: function(url, params, headers, callback) {
        return this.exec('get', url, params, headers, callback);
      },
      post: function(url, params, headers, callback) {
        return this.exec('post', url, params, headers, callback);
      },
      put: function(url, params, headers, callback) {
        return this.exec('put', url, params, headers, callback);
      },
      patch: function(url, params, headers, callback) {
        return this.exec('patch', url, params, headers, callback);
      },
      del: function(url, params, headers, callback) {
        return this.exec('del', url, params, headers, callback);
      },
      exec: function(method, url, params, headers, callback) {
        var keys, req;
        if (!headers) {
          headers = params;
          params = {};
        }
        if (!callback) {
          callback = headers;
          headers = {};
        }
        method = indexOf.call(httpMethods, method) >= 0 ? method : 'get';
        params.access_token = this.accessToken;
        if (method === 'get') {
          url += "?" + (querystring.stringify(params));
        }
        req = request[method](url);
        if (method !== 'get') {
          req = req.send(params);
        }
        keys = Object.keys(headers);
        if (keys.length !== 0) {
          keys.forEach(function(key) {
            return req.set(key, headers[key]);
          });
        }
        return req.end(callback);
      }
    };
    client.api = api(client);
    return client;
  };

}).call(this);
