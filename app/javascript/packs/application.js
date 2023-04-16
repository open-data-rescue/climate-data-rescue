// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import * as ActiveStorage from "@rails/activestorage"

import 'jquery'
import 'jquery-ujs'
import 'bootstrap'

// import 'bootstrap-switch.css'
import 'bootstrap-switch'
import 'trumbowyg'

import "jquery-ui/jquery-ui.js"

require ("blueimp-file-upload/js/jquery.fileupload.js");

// require('./jquery.fileupload-process')

// NOTE: change this to the dist once JQuery goes to 3.7 or select2 focus bug is fixed
// import "select2/js/select2.full.js"
require("../utils/select2.full.js");

require("underscore/underscore.js");

require("backbone/backbone.js");

require("backbone.marionette/lib/backbone.marionette.js");
require("backbone.wreqr/lib/backbone.wreqr.js");
require("backbone-forms/distribution/backbone-forms");
require("backbone-forms/distribution/adapters/backbone.bootstrap-modal.js");
require("backbone-forms/distribution/editors/list");
// TODO: change later date because module does not work with the old code
require("../utils/fileUploadEditor.js");
// import "backbone-forms/distribution/editors/fileUploadEditor"

// require("backbone-model-file-upload/backbone-model-file-upload.js");
require("../utils/backbone-model-file-upload.js");

require("jquery.kinetic/jquery.kinetic.js");
require("magnify/dist/js/jquery.magnify.js");
require("magnify/dist/js/jquery.magnify-mobile.js");

require("../utils/page-uploader-plugin.js");
require("../utils/boxer-plugin.js");
require("../utils/content_images.js");
require("../utils/snowEffect.js");

import 'stylesheets/theme.scss'
import 'stylesheets/transcriptions.scss'

import 'magnify/dist/css/magnify.css'

import "tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css"

import "trumbowyg/icons.svg"

// see https://dev.to/shivashankarror/rails-6-using-images-with-webpacker-and-asset-pipeline-4gk3
const images = require.context('../images', true)

// Expoed modules for erbs
import Bowser from "expose-loader?exposes=Bowser!bowser/bundled.js";
import _ from "expose-loader?exposes=_!underscore/underscore.js";
import Marionette from "expose-loader?exposes=Marionette!backbone.marionette/lib/backbone.marionette";
require("../templates/bootstrap4.js");

// import Moment from "expose-loader?exposes=Moment!moment/moment.js"
import moment from "expose-loader?exposes=moment!moment/moment.js"

require("tempusdominus-bootstrap-4/build/js/tempusdominus-bootstrap-4.js");

require("bootstrap-notify/bootstrap-notify.js");

// Rails.start()
ActiveStorage.start()

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
})

$(document).ready(function(){
  _.templateSettings = {
        interpolate : /\{\{\=(.+?)\}\}/g,
        evaluate : /\{\{(.+?)\}\}/g,
        // escape:    /{{-([\s\S]+?)}}/g
    };

    // Over-ride the backbone sync so that the rails CSRF token is passed to the backend
    Backbone._sync = Backbone.sync;
    Backbone.sync = function(method, model, options) {
      // is this working
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

// function alertMessageJson(message) {
//     var msg = '';
//     // console.log(message);
//     if (message && message.isArray){
//         message.each(function(el,idx,arr){
//             console.log(el);
//             el.error.each(function(e){
//                 msg += e;
//                 if (el.error.length > 0) {
//                     msg += '<br />';
//                 }
//             });
//         });
//
//         alertMessage(msg);
//     } else if (message && message.error){
//       alertMessage(message.error);
//     }
// };

function alertMessage(message) {
    $('#message-container').html("<div class=\"alert alert-warning fade in\"><button class=\"close\" data-dismiss=\"alert\"><span class=\"glyphicon glyphicon-remove\" style=\"margin-right: 14px\"></span></button>"+ message +"</div>");
};
