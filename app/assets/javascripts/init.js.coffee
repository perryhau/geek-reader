window.debug = console.debug.bind(console)
window.log = console.log.bind(console)
window.warn = console.warn.bind(console)

window.Reader =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  flashMessage: (msg)->
    flash = $("<div class='flash'><span class='alert alert-success'>#{msg}</span></div>")
    flash.appendTo($("body"))
    setTimeout ( -> flash.fadeOut(400, -> $(@).remove())), 4000

  initialize: ->
    # initialize data objects
    r = Reader
    r.categories = new Reader.Collections.Categories
    r.unread_entries = new Reader.Collections.UnreadEntries
    r.starred_entries = new Reader.Collections.StarredEntries
    # initialize view objects
    r.menu_manager = new Reader.Views.MenuManager
    r.display_manager = new Reader.Views.DisplayManager
    # initialize router
    r.router = new Reader.Routers.Main

$(document).ready ->
  Reader.initialize()