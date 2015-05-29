# esa-nodejs

esa API v1 client library, written in Node.js

https://docs.esa.io/posts/109

https://docs.esa.io/posts/102


## Installation

```
npm install esa-nodejs
```


## Usage

```javascript
var esa = require('esa-nodejs');
client = esa({
  team: 'teamname',
  accessToken: 'api access token'
});

client.team
//=> 'teamname'

client.accessToken = 'api access token'
//=> 'api access token'

// GET /v1/teams
client.api.teams(function(err, res) {
  console.log(err);
  console.log(res.body);
});

// GET /v1/teams/:team_name
client.api.team(function(err, res) {
  console.log(err);
  console.log(res.body);
});

// GET /v1/teams/:team_name/posts
client.api.posts(function(err, res) {
  console.log(err);
  console.log(res.body);
});

// POST /v1/teams/:team_name/posts
client.api.createPost({name: 'foo'}, function(err, res) {
  console.log(err);
  console.log(res.body);
});

// PATCH /v1/teams/:team_name/posts/:number
client.api.updatePost(1, {name: 'foo update'}, function(err, res) {
  console.log(err);
  console.log(res.body);
});

// DELETE /v1/teams/:team_name/posts/:number
client.api.updatePost(1, function(err, res) {
  console.log(err);
  console.log(res.body);
});

```
