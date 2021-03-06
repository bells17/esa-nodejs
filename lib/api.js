(function() {
  module.exports = function(client) {
    return {
      client: client,

      /*
      GET /api/v1/teams
      https://docs.esa.io/posts/102#4-1-0
       */
      teams: function(params, headers, callback) {
        var url;
        url = this.client.url(false);
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name
      https://docs.esa.io/posts/102#4-2-0
       */
      team: function(params, headers, callback) {
        var url;
        url = this.client.url();
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/stats
      https://docs.esa.io/posts/102#5-1-0
       */
      stats: function(params, headers, callback) {
        var url;
        url = this.client.url() + 'stats';
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/members
      https://docs.esa.io/posts/102#6-1-0
       */
      members: function(params, headers, callback) {
        var url;
        url = this.client.url() + 'members';
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/posts
      https://docs.esa.io/posts/102#5-1-0
       */
      posts: function(params, headers, callback) {
        var url;
        url = this.client.url() + 'posts';
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/posts/:post_number
      https://docs.esa.io/posts/102#5-2-0
       */
      post: function(number, params, headers, callback) {
        var url;
        url = this.client.url() + ("posts/" + (number || ''));
        return this.client.get(url, params, headers, callback);
      },

      /*
      POST /api/v1/teams/:team_name/posts
      https://docs.esa.io/posts/102#5-3-0
       */
      createPost: function(params, headers, callback) {
        var url;
        url = this.client.url() + 'posts';
        return this.client.post(url, params, headers, callback);
      },

      /*
      PATCH /api/v1/teams/:team_name/posts/:post_number
      https://docs.esa.io/posts/102#5-4-0
       */
      updatePost: function(number, params, headers, callback) {
        var url;
        url = this.client.url() + ("posts/" + (number || ''));
        return this.client.patch(url, params, headers, callback);
      },

      /*
      DELETE /api/v1/teams/:team_name/posts/:post_number
      https://docs.esa.io/posts/102#5-5-0
       */
      deletePost: function(number, params, headers, callback) {
        var url;
        url = this.client.url() + ("posts/" + (number || ''));
        return this.client.del(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/posts/:post_number/comments
      https://docs.esa.io/posts/102#6-1-0
       */
      comments: function(number, params, headers, callback) {
        var url;
        url = this.client.url() + ("posts/" + (number || '') + "/comments");
        return this.client.get(url, params, headers, callback);
      },

      /*
      GET /api/v1/teams/:team_name/comments/:comment_id
      https://docs.esa.io/posts/102#6-2-0
       */
      comment: function(id, params, headers, callback) {
        var url;
        url = this.client.url() + ("comments/" + (id || ''));
        return this.client.get(url, params, headers, callback);
      },

      /*
      POST /api/v1/teams/:team_name/posts/:post_number/comments
      https://docs.esa.io/posts/102#6-3-0
       */
      createComment: function(number, params, headers, callback) {
        var url;
        url = this.client.url() + ("posts/" + (number || '') + "/comments");
        return this.client.post(url, params, headers, callback);
      },

      /*
      PATCH /api/v1/teams/:team_name/comments/:comment_id
      https://docs.esa.io/posts/102#6-4-0
       */
      updateComment: function(id, params, headers, callback) {
        var url;
        url = this.client.url() + ("comments/" + (id || ''));
        return this.client.patch(url, params, headers, callback);
      },

      /*
      DELETE /api/v1/teams/:team_name/comments/:comment_id
      https://docs.esa.io/posts/102#6-5-0
       */
      deleteComment: function(id, params, headers, callback) {
        var url;
        url = this.client.url() + ("comments/" + (id || ''));
        return this.client.del(url, params, headers, callback);
      }
    };
  };

}).call(this);
