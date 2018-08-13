$(document).on 'turbolinks:load', ->
	FARMA.toggleDeveloperLeaveDate()

FARMA.toggleDeveloperLeaveDate = ->
	if $('#admin_developer_active').is(":checked")
		$('#date_leave_project').hide()

	$('#admin_developer_active').click ->
		$('#date_leave_project').toggle()



