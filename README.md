# esa-nodejs

[![npm version](https://badge.fury.io/js/esa-nodejs.svg)](http://badge.fury.io/js/esa-nodejs) [![Build Status](https://travis-ci.org/bells17/esa-nodejs.svg?branch=master)](https://travis-ci.org/bells17/esa-nodejs)

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

client.accessToken
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
client.api.updatePost(postNumber, {name: 'foo update'}, function(err, res) {
  console.log(err);
  console.log(res.body);
});

// DELETE /v1/teams/:team_name/posts/:number
client.api.deletePost(postNumber, function(err, res) {
  console.log(err);
  console.log(res.body);
});

// GET /api/v1/teams/:team_name/posts/:post_number/comments
client.api.comments(postNumber, function(err, res) {
  console.log(err);
  console.log(res.body.comments);
});

// GET /api/v1/teams/:team_name/comments/:comment_id
client.api.comment(commentId, function(err, res) {
  console.log(err);
  return console.log(res.body);
});

// POST /api/v1/teams/:team_name/posts/:post_number/comments
client.api.createComment(postNumber, {comment: { body_md: 'api create comment' } }, function(err, res) {
  console.log(err);
  return console.log(res.body);
});

// PATCH /api/v1/teams/:team_name/comments/:comment_id
client.api.updateComment(commentId, {comment: { body_md: 'api create comment' } }, function(err, res) {
  console.log(err);
  return console.log(res.body);
});

// DELETE /api/v1/teams/:team_name/comments/:comment_id
client.api.deleteComment(commentId, function(err, res) {
  console.log(err);
  return console.log(res.body);
});

```
