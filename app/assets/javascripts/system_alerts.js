function fade_out_system_alerts(){
  $(".system-alert").delay(5000).slideUp(2000); 
};

$(document).ajaxSuccess(function( event, request, settings ) {
  fade_out_system_alerts();
});