window.FARMA.imagePreview = ->
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
