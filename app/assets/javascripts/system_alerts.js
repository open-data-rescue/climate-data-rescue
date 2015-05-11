function fade_out_system_alerts(){
  $(".system-alert").delay(2000).slideUp(2000); 
};

$(document).ajaxSuccess(function( event, request, settings ) {
  fade_out_system_alerts();
});