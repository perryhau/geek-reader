class Reader.Routers.Main extends Backbone.Router
  routes:
    "" : "home"
    "feeds/:cid/:id" : "show_feed"
    "unread" : "show_unread"
    "starred" : "show_starred"

  initialize: ->
    resize_height = ->
      h = $(".content:visible .head").outerHeight(true)
      f = $("#footer").outerHeight(true)
      b = $(window).outerHeight(true) - h
      $(".content:visible .body").height(b)
      $("#menu").height(b)
    $(window).resize (ev) -> resize_height()

    got_categories = ->
      d = $.Deferred()
      Reader.categories.fetch {reset: true, parse: true, success: -> d.resolve()}
      d.promise()

    $.when(got_categories()).done ->
      Backbone.history.start()

  show_feed: (cid, fid)->
    Reader.menu_manager.cats_menu.open_feed(cid, fid)

  show_unread: ->
    Reader.display_manager.render_entries(Reader.unread_entries)

  show_starred: ->
    Reader.display_manager.render_entries(Reader.starred_entries)

  home: ->
    @show_unread()

