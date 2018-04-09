$(document).on 'turbolinks:load', ->
	FARMA.toggleDeveloperLeaveDate()
	FARMA.showAvatarPreview()


FARMA.toggleDeveloperLeaveDate = ->
	if $('#admin_developer_active').is(":checked")
		$('#date_leave_project').hide()

	$('#admin_developer_active').click ->
		$('#date_leave_project').toggle()

FARMA.showAvatarPreview = ->
  # Display the image to be uploaded.
  $('.photo_upload').on 'change', (e) ->
    readURL(this);

  readURL = (input) ->
    if (input.files && input.files[0])
      reader = new FileReader()

    reader.onload = (e) ->
      $('.image_to_upload').attr('src', e.target.result).removeClass('hidden');
      $swap = $('.swap')
      if $swap
        $swap.removeClass('hidden')

    reader.readAsDataURL(input.files[0]);

