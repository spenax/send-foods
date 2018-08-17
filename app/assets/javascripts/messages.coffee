# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



words = ['eating for lunch', 'playing', 'sipping on', 'buying', 'wearing', 'cooking for dinner', 'watching', 'betting on']

changeHeader = (activities) ->
  if (document.getElementById("hotWord"))
    setInterval () ->
      rand = Math.floor(Math.random() * activities.length)
      document.getElementById("hotWord").innerHTML = activities[rand]
    , 2000
  else
    return

#$(document).ready ->
$(document).on "turbolinks:load", ->
  if (!($("#hotWord").length > 0))
    return
  else
    changeHeader(words)
