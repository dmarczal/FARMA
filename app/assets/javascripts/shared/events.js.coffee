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

######################################
# Over insteadof click on card reveal
######################################
FARMA.mouseOverOnCard = (selector) ->
  $(selector).mouseenter (e) ->
    if $(@).find('> .card-reveal').length
      if $(e.target).is($('.card .activator')) || $(e.target).is($('.card .activator i'))
        # Make Reveal animate up
        car_reveal = $(@).find('.card-reveal')
        car_reveal.css({ display: 'block'})
        car_reveal.velocity("stop", false)
        car_reveal.velocity({translateY: '-100%'},
                            {duration: 300, queue: false, easing: 'easeInOutQuad'})

      $('.card-reveal').closest('.card').css('overflow', 'hidden');

  $(selector).mouseleave ->
    # Make Reveal animate down and display none
    $(@).find('.card-reveal').velocity {translateY: 0},
       duration: 225,
       queue: false,
       easing: 'easeInOutQuad',
       complete: ->
          $(this).css({ display: 'none'})
