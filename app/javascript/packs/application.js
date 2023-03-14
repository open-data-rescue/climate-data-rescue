// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"

import * as ActiveStorage from "@rails/activestorage"

import 'jquery'
import 'bootstrap'

// import 'bootstrap-switch.css'
import 'bootstrap-switch'
import 'trumbowyg'

import "jquery-ui/jquery-ui.js"
import "blueimp-file-upload/js/jquery.fileupload.js"

import "select2/js/select2.full.js"

import "underscore/underscore.js"
import "backbone/backbone.js"
import "backbone.marionette/lib/backbone.marionette.js"
import "backbone-model-file-upload/backbone-model-file-upload.js"
import "backbone.wreqr/lib/backbone.wreqr.js"

import "backbone-forms/distribution/backbone-forms"
import "backbone-forms/distribution/editors/list"
// import "backbone-forms/distribution/editors/fileUploadEditor"
import "backbone-forms/distribution/adapters/backbone.bootstrap-modal.js"
import "backbone-forms/distribution/templates/bootstrap.js"

import "jquery.kinetic/jquery.kinetic.js"
// import "magnify/dist/js/jquery.magnify.js"
import "eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"
//= require moment/min/moment.min
//= require eonasdan-bootstrap-datetimepicker/src/js/bootstrap-datetimepicker

// TODO: no repo?
// require jquery.ba-outside-events.min
// require magnify/jquery.magnify-mobile
// import "magnify/dist/js/jquery.magnify.js"

import "../utils/page-uploader-plugin.js"
import "../utils/boxer-plugin.js"
import "../utils/content_images.js"
import "../utils/snowEffect.js"


Rails.start()
ActiveStorage.start()

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
})

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


    // $('[data-toggle="popover"]').popover();
    // $('[data-toggle="tooltip"]').tooltip();

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
