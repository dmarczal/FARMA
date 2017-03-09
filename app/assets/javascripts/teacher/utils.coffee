# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.FARMA.toggleVerticalMenu = ->
  $('#button-panel').click ->
    $('#panel').toggleClass 'active'

    if $('#panel').hasClass 'active'
      $('#content-teacher').removeClass('l12').addClass('l9 offset-l2')
      $('#logo-container').removeClass 'center-logo'
      $('#container').removeClass 'container'

    $("#panel").animate({'width' : 'toggle'}, 200, 'linear', ->
          unless $('#panel').hasClass 'active'
            $('#content-teacher').removeClass('l9 offset-l2').addClass('l12')
            $('#logo-container').addClass 'center-logo'
            $('#container').addClass 'container'
      )

window.FARMA.fixTooltip = ->
  $('.material-tooltip').hide()

window.FARMA.silentSubmit = ->
  $('#lo_image').change ->
    $('.edit_lo').submit()
    toastr.success("Imagem atualizada!")

  $(document).on 'click', '.lo-title', ->
    clone = $(this).clone()
    $(@).replaceWith('<input class="string required input-lo-title edit-line" autofocus="autofocus" type="text" value="' + clone[0].innerText.trim() + '" name="lo[name]" id="lo_name">')

  $(document).on 'click', '.lo-description', ->
    clone = $(this).clone()
    $(@).replaceWith('<input class="string required input-lo-description edit-line" autofocus="autofocus" type="text" value="' + clone[0].innerText.trim() + '" name="lo[description]" id="lo_description">')

  $(document).on 'blur', '.edit-line', ->
    $('.edit_lo').submit()
    toastr.success("Informações atualizadas")
