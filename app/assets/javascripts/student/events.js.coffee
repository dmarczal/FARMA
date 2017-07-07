$(document).on 'turbolinks:load', ->
  FARMA.barsUpdate()
  FARMA.changeTitleTeam()

FARMA.changeTitleTeam = ->
  $('#teams .tab a').click ->
    title = $(@).text()
    $('#teams header h1').text("Turmas #{title}")

FARMA.barsUpdate = ->
  if $('div.bar').length > 0
    FARMA.setbars()

FARMA.setbars = ->
  width = $('.bar').width()
  progressPersent = parseInt($('.progress-bar').data('percent'))
  viewPersent = parseInt($('.view-bar').data('percent'))

  progressWidth = width * progressPersent/100
  viewWidth = width * viewPersent/100

  $('.progress-bar').width(progressWidth)
  $('.view-bar').width(viewWidth)
