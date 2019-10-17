$(document).on 'turbolinks:load', ->
  FARMA.toggleCard()
  FARMA.silentSubmit()
  FARMA.imagePreview()
  FARMA.clickContentCard()

###################################################################################################
################################## Toggle card - Lo  ##############################################
###################################################################################################

FARMA.toggleCard = ->
  $('.card-head').click ->
    $($(@).data('card')).slideDown()

  $('.card-content .close').click ->
    $(@).parent().slideUp()


FARMA.clickContentCard = ->
  $('.card-title').click ->
    $(@).parent().click()

###################################################################################################
################################## silent submit ##################################################
###################################################################################################

FARMA.silentSubmit = ->
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

###################################################################################################
################################## image preview ##################################################
###################################################################################################

FARMA.imagePreview = ->
  readURL = (input)->
    if input.files && input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('.file_preview').attr 'src', e.target.result
        $('.file_preview').addClass('active');
        $('.text-box').css('display','none');

      reader.readAsDataURL input.files[0]

  $('input[type="file"]').change ->
      readURL this
