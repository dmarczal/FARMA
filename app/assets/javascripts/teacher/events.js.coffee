$(document).on 'turbolinks:load', ->
  FARMA.toggleCard()

######################################
# Toggle card
######################################

FARMA.toggleCard = ->
  $('.card-head').click ->
    $($(@).data('card')).slideDown()

  $('.card-content .close').click ->
    $(@).parent().slideUp()
