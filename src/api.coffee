module.exports = (client)->
  {
    client: client

    ###
    GET /api/v1/teams
    https://docs.esa.io/posts/102#4-1-0
    ###
    teams: (params, headers, callback)->
      url = @client.url false
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name
    https://docs.esa.io/posts/102#4-2-0
    ###
    team: (params, headers, callback)->
      url = @client.url()
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/stats
    https://docs.esa.io/posts/102#5-1-0
    ###
    stats: (params, headers, callback)->
      url = @client.url() + 'stats'
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/members
    https://docs.esa.io/posts/102#6-1-0
    ###
    members: (params, headers, callback)->
      url = @client.url() + 'members'
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/posts
    https://docs.esa.io/posts/102#5-1-0 
    ###
    posts: (params, headers, callback)->
      url = @client.url() + 'posts'
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/posts/:post_number
    https://docs.esa.io/posts/102#5-2-0
    ###
    post: (number, params, headers, callback)->
      url = @client.url() + "posts/#{number or ''}"
      @client.get url, params, headers, callback

    ###
    POST /api/v1/teams/:team_name/posts
    https://docs.esa.io/posts/102#5-3-0
    ###
    createPost: (params, headers, callback)->
      url = @client.url() + 'posts'
      @client.post url, params, headers, callback

    ###
    PATCH /api/v1/teams/:team_name/posts/:post_number
    https://docs.esa.io/posts/102#5-4-0
    ###
    updatePost: (number, params, headers, callback)->
      url = @client.url() + "posts/#{number or ''}"
      @client.patch url, params, headers, callback

    ###
    DELETE /api/v1/teams/:team_name/posts/:post_number
    https://docs.esa.io/posts/102#5-5-0
    ###
    deletePost: (number, params, headers, callback)->
      url = @client.url() + "posts/#{number or ''}"
      @client.del url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/posts/:post_number/comments
    https://docs.esa.io/posts/102#6-1-0
    ###
    comments: (number, params, headers, callback)->
      url = @client.url() + "posts/#{number or ''}/comments"
      @client.get url, params, headers, callback

    ###
    GET /api/v1/teams/:team_name/comments/:comment_id
    https://docs.esa.io/posts/102#6-2-0
    ###
    comment: (id, params, headers, callback)->
      url = @client.url() + "comments/#{id or ''}"
      @client.get url, params, headers, callback

    ###
    POST /api/v1/teams/:team_name/posts/:post_number/comments
    https://docs.esa.io/posts/102#6-3-0
    ###
    createComment: (number, params, headers, callback)->
      url = @client.url() + "posts/#{number or ''}/comments"
      @client.post url, params, headers, callback
    
    ###
    PATCH /api/v1/teams/:team_name/comments/:comment_id
    https://docs.esa.io/posts/102#6-4-0
    ###
    updateComment: (id, params, headers, callback)->
      url = @client.url() + "comments/#{id or ''}"
      @client.patch url, params, headers, callback

    ###
    DELETE /api/v1/teams/:team_name/comments/:comment_id
    https://docs.esa.io/posts/102#6-5-0
    ###
    deleteComment: (id, params, headers, callback)->
      url = @client.url() + "comments/#{id or ''}"
      @client.del url, params, headers, callback

  }
