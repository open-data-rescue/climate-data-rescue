// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require jquery-fileupload
//= require page-uploader-plugin
//= require_tree .

// $(function(){ 
  // $(document).foundation();
  // fade_out_system_alerts();
// });
// 
// $(function(){ $(document).foundation(); });

$(document).ready(function(){
	
});

function alertMessageJson(message) {
    var msg = '';
    console.log(message);
    if (message){
        message.forEach(function(el,idx,arr){
            console.log(el);
            el.error.forEach(function(e){
                msg += e;
                if (el.error.length > 0) {
                    msg += '<br />';
                }
            });
        });
        
        alertMessage(msg);
    }
};

function alertMessage(message) {
    $('#message-container').html("<div class=\"alert alert-warning fade in\"><button class=\"close\" data-dismiss=\"alert\"><span class=\"glyphicon glyphicon-remove\" style=\"margin-right: 14px\"></span></button>"+ message +"</div>");
};
