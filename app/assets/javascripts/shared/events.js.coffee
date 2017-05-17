$(document).on 'turbolinks:load', ->
  FARMA.materializeSwitchEvent()

######################################
# Change page when click on swith
######################################
FARMA.materializeSwitchEvent = ->
  $('.switch-workspace input[type="checkbox"]').on 'change', ->
    url = $(@).data('switch-to-url')
    $(this).attr('disabled', 'disabled')
    window.location = url
