// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"

import * as ActiveStorage from "@rails/activestorage"

import 'bootstrap'

// import 'bootstrap-switch.css'
import 'bootstrap-switch'
import 'trumbowyg'

import "jquery-ui/jquery-ui.js"

Rails.start()
ActiveStorage.start()

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
})
