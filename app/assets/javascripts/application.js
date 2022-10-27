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
//= require jquery.ba-outside-events.min
//= require modernizr
//= require moment/min/moment.min
//= require bootstrap-sprockets
//= require bootstrap-switch/dist/js/bootstrap-switch
//= require select2-full-custom
//= require jquery-fileupload
//= require page-uploader-plugin
//= require boxer-plugin
//= require jquery.kinetic
//= require trumbowyg/dist/trumbowyg
//= require eonasdan-bootstrap-datetimepicker/src/js/bootstrap-datetimepicker
//
//= require backbone/underscore
//= require backbone/backbone
//= require backbone/backbone.marionette/
//= require backbone/backbone-model-file-upload
//= require backbone/backbone.wreqr
//
//= require backbone-forms/distribution/backbone-forms
//= require backbone-forms/distribution/editors/list
//= require backbone-forms/distribution/editors/fileUploadEditor
//= require backbone-forms/bootstrap-modal
//= require backbone-forms/distribution/templates/bootstrap3
//
// 
//= require wickedpicker
//= require magnify/jquery.magnify
//= require magnify/jquery.magnify-mobile
//= require bootstrap-notify/bootstrap-notify
//
//= require content_images
//= require snowEffect
//
//= require_self



$(document).ready(function(){
  _.templateSettings = {
        interpolate : /\{\{\=(.+?)\}\}/g,
        evaluate : /\{\{(.+?)\}\}/g
    };

    // Over-ride the backbone sync so that the rails CSRF token is passed to the backend
    Backbone._sync = Backbone.sync;
    Backbone.sync = function(method, model, options) {
        if (method == 'create' || method == 'update' || method == 'delete') {
            var auth_options = {};
            auth_options[$("meta[name='csrf-param']").attr('content')] = $("meta[name='csrf-token']").attr('content');
            model.set(auth_options, {silent: true});
        };
        options.error = function(response) {
            if (response.status > 0) {
                if (response.responseText) {
                    if (options.handle_error) {
                        options.handle_error(response);
                    } else {
                        alertMessage(response.responseText);
                    }
                } else {
                    alertMessage("Error communicating with backend ..."); // TODO - change to translatable string
                };
            };
        };
        
        return Backbone._sync(method, model, options);
    };


    $('[data-toggle="popover"]').popover();
    $('[data-toggle="tooltip"]').tooltip();    

    window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
          $(this).remove();
      });
    }, 5000);
});


// Dynamically sticky footer
$(window).bind("load", function() { 
       
       var footerHeight = 0,
           footerTop = 0,
           $footer = $(".footer");
           
       positionFooter();
       
       function positionFooter() {
       
                footerHeight = $footer.height();
                footerTop = ($(window).scrollTop()+$(window).height()-footerHeight)+"px";
       
               if ( ($(document.body).height()) < $(window).height()) {
                   $footer.css({
                        position: "absolute"
                   }).animate({
                        top: footerTop
                   })
               } else {
                   $footer.css({
                        position: "static"
                   })
               }
               
       }

       $(window)
               .scroll(positionFooter)
               .resize(positionFooter)
               
});

function alertMessageJson(message) {
    var msg = '';
    console.log(message);
    if (message && message.isArray){
        message.each(function(el,idx,arr){
            console.log(el);
            el.error.each(function(e){
                msg += e;
                if (el.error.length > 0) {
                    msg += '<br />';
                }
            });
        });
        
        alertMessage(msg);
    } else if (message && message.error){
      alertMessage(message.error);
    }
};

function alertMessage(message) {
    $('#message-container').html("<div class=\"alert alert-warning fade in\"><button class=\"close\" data-dismiss=\"alert\"><span class=\"glyphicon glyphicon-remove\" style=\"margin-right: 14px\"></span></button>"+ message +"</div>");
};
