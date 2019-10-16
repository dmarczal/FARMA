$(document).on 'turbolinks:load', ->
  FARMA.materializeSwitchEvent()
  FARMA.toggleDropdown()
  FARMA.activeDropdown()

######################################
# Change page when click on swith
######################################

FARMA.materializeSwitchEvent = ->
  $('.switch-workspace input[type="checkbox"]').on 'change', ->
    url = $(@).data('switch-to-url')
    $(this).attr('disabled', 'disabled')
    window.location = url

######################################
# Toggle dropdown in sidebar
######################################

FARMA.toggleDropdown = ->
  $('.dropdown-sidebar').on 'click', (event)->
    event.preventDefault()
    $(@).parent().toggleClass('active')
    idLiDropdown = $(@).attr('href')
    $(idLiDropdown).slideToggle()

######################################
# Set active in dropdown
######################################

FARMA.activeDropdown = ->
  if $('li.dropdown').length > 0
    $('li.dropdown').each ->
        if $(@).children().children().hasClass('active')
          $(@).show()
          idDropdown = $(@).data('dropdown')
          $(idDropdown).addClass('active')
