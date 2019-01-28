window.DistritoRugby = {}
window.DistritoRugby.init = ->
	console.log 'Made by @jsamzapata'

$(document).on 'turbolinks:load', ->
  DistritoRugby.init()
