$(document).on 'turbolinks:load', ->
  FARMA.toggleCard()
  FARMA.modalOpen()
  FARMA.showQuestion()
  FARMA.requestEditQuestion()
  FARMA.requestFormTip()
  FARMA.silentSubmit()
  FARMA.closeNewQuestion()
  FARMA.imagePreview()
  # FARMA.toggleVerticalMenu() Remove toggle sidebar because it's useless


###################################################################################################
################################## Toggle card - Lo  ##############################################
###################################################################################################

FARMA.toggleCard = ->
  $('.card-head').click ->
    $($(@).data('card')).slideDown()

  $('.card-content .close').click ->
    $(@).parent().slideUp()

###################################################################################################
################################## Toggle new Question ############################################
###################################################################################################

FARMA.closeNewQuestion = ->
  $('#box-new-question').on 'click', '.cancel-new-question', ->
    FARMA.toggleNewQuestion()


###################################################################################################
################################## Modal open - New Question ######################################
###################################################################################################

FARMA.modalOpen = ->
  $('.fixed-modal-btn').click ->
    FARMA.toggleNewQuestion()

  $('#content-teacher').on 'click', '.cancel-new-question',->
    FARMA.toggleNewQuestion()

###################################################################################################
################################## Show Question - Open card ######################################
###################################################################################################

FARMA.showQuestion = ->
  $('#questions_list').on 'click', '.show-question', ->
    FARMA.slideQuestion this;

###################################################################################################
################################## Request Box Edit-question ######################################
###################################################################################################

FARMA.requestEditQuestion = ->
  $('#content-teacher').on 'click', '.ajax-question-box .btn-cancel-question', ->
    FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')

  $('#content-teacher').on 'click', '.edit-question', ->
    FARMA.slideQuestion '#show-question-' + $(this).attr('data-id')

###################################################################################################
################################## Request form new Tip ###########################################
###################################################################################################

FARMA.requestFormTip = ->
  $('#main-content').on 'click', '.new-tip-btn', ->
    $(@).hide()
    FARMA.toggleBoxNewTip '#box-new-tips-for-' + $(this).attr('data-id')

  $('#main-content').on 'click', '.close-tip', ->
    id = $(this).attr('data-id')
    $("#question-#{id}-show .new-tip-btn").show()
    FARMA.toggleBoxNewTip '#box-new-tips-for-' + id

# ###################################################################################################
# ################################## Toggle card ####################################################
# ###################################################################################################
#
# FARMA.toggleVerticalMenu = ->
#   $('#button-panel').click ->
#     $('#panel').toggleClass 'active'
#
#     if $('#panel').hasClass 'active'
#       $('#content-teacher').removeClass('l12').addClass('l9 offset-l2')
#       $('#logo-container').removeClass 'center-logo'
#       $('#container').removeClass 'container'
#
#     $("#panel").animate({'width' : 'toggle'}, 200, 'linear', ->
#           unless $('#panel').hasClass 'active'
#             $('#content-teacher').removeClass('l9 offset-l2').addClass('l12')
#             $('#logo-container').addClass 'center-logo'
#             $('#container').addClass 'container'
#       )

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

  $("#lo_image").change ->
      readURL this
