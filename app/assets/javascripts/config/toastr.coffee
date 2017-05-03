FARMA.displayFlashMessages = (type, message) ->
  toastr.options =
    "positionClass" : "toast-top-right",
    "closeButton" : false,
    "debug" : false,
    "progressBar": true,
    "newestOnTop" : true,
    "preventDuplicates" : false,
    "onclick" : null,
    "showDuration" : "3000",
    "hideDuration" : "1000",
    "timeOut" : "5000",
    "extendedTimeOut" : "1000",
    "showEasing" : "swing",
    "hideEasing" : "linear",
    "showMethod" : "fadeIn",
    "hideMethod" : "fadeOut"

  Command: toastr[type](message)