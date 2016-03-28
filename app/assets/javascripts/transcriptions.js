$(document).ready(function(){
//Javascript for custom functionality on new transcription page. 
//All javascript written by the author unless otherwise credited. 
//Code credited as "sourced from" have been modified little to none. 
//Code credited as "adapted from" uses ideas and some lines from the credited location while modifying them to work with this project

//global variables
  var annotationCount = 0; //keep track of how many annotations have been created on current page
  var countDiv; 
  /* used to add hidden fields to the form of a newly created annotation form. Facilitates selection of the correct form
  for jquery operations. Contents equal the html id "new_annotation" + current annotation count. Iterates on each new form creation */
  var formDataCount;
  /*used to select the correct annotation form input to place JSON data from transcription box form. Contents equal the html id 
  "formData" + current annotation count. Iterates on each new form creation */
  var currentFieldGroup = $('.scribe_tab.scribe_selected_tab').attr('id'); //jquery selector to get the id of the currently selected tab
//end global vars

//make transcription elements resizable and draggable
  $( "#scribe_zoom_box" ).resizable();
  $( "#scribe_transcription_area" ).resizable();
//end transcription box controls

//on transcription form submit, capture input as json and close the transcription box
  //json grabber function. Sourced from http://jsfiddle.net/davidhong/gP9bh/
    $.fn.serializeObject = function() {
      var a, o;
      o = {};
      a = this.serializeArray();
      $.each(a, function() {
        if (o[this.name] !== void 0) {
          if (!o[this.name].push) {
            o[this.name] = [o[this.name]];
          }
          o[this.name].push(this.value || '');
        } else {
          o[this.name] = this.value || '';
        }
      });
      return o;
    };
  //end json grabber

  /*call json grabber on form submit, put it in a box on the page. Converts form inputs to JSON. Adapted from 
  http://jsfiddle.net/davidhong/gP9bh/ */
    $(function() {
      $('.transcription_form').submit(function(event) {
        event.preventDefault();/*supress default submit action of refreshing the page, so we can add more than one annoation to the 
        transcription */
        $('#scribe_annotation_box').hide(); //hide transcription box on form submission
        annotationCount = annotationCount + 1; //iterate annotation count
        countDiv = "new_annotation" + annotationCount;
        formDataCount = "formData" + annotationCount;
        addForm(); //Add new annotation creation form below image to place JSON data for uplaod to annotation's data attribute
        /*add attributes to the new form element that couldn't be added in the addForm() function due to the dash in the attribute name.
        Essential for model instance creation form.*/
        $('#' + countDiv).attr("accept-charset", "UTF-8");
        $('#' + countDiv).attr("data-remote", "true");
        var formContents = JSON.stringify($('#currentForm').serializeObject()); /*set formContents variable to the JSON string from 
        the transcription form*/
        $('#' + formDataCount).val(formContents); //set value of new annotation form :data input field to the JSON string
        return;
        
      });

      return false;
    });
//end form submit action

//function to toggle between field group form layers when you click on their respective tab. Marks current tab as active
  $(".scribe_tab").click(function(){ /* perform function when user click on an element with the "scribe_tab" class. Corresponds 
  to Field Group tabs in the transcription box */
     $tab = $(this);
     $(".transcription_form").hide(); //hide all other instances of the field_group data forms when switching tabs
     $('#formInstructions').hide();
     $tab.addClass("scribe_selected_tab"); //mark clicked tab as active by settings its class
     // $('#currentForm').removeAttr('id', 'currentForm'); //remove the ID 'currentForm' from whichever element currently has it
     // $('#' + $(this).attr("divId")).parents('form').attr('id', 'currentForm');//mark form associated with the clicked tab as 'currentForm'

     $tab.siblings().removeClass('scribe_selected_tab'); //set all siblings of the clicked tab as unselected
     
     var $currentForm = $("form#" + $tab.data('form-id'));
     $currentForm.show();

     //console.log('success'); 
  });
//end field toggler

//open transcription box at page image mouse click position
  $("#baseImage").click(function(e){
     $("#scribe_annotation_box").show(500); /*open the box with a delay of half a second. This is what makes the transcription 
     box open with a flourish. Remove the value from the .show() function to make it open instantly */
     $("#scribe_annotation_box").offset({left:e.pageX,top:e.pageY}); //set position of the box to open at the click event 'e' position
  });
//end transcription box toggle

/*function to enable the image zoom box. Adapted from http://thecodeplayer.com/walkthrough/magnifying-glass-for-images-using-jquery-and-css3
and http://jsfiddle.net/aasFx/ */
  $(document).ready(function()
  {
      var native_width = 0;
      var native_height = 0;

      $("#scribe_annotation_box").draggable(
      {
          containment: "#magnify",
          scroll: false,
          drag: function()
          {
              if (!native_width && !native_height)
              {
                  var image_object = new Image();
                  image_object.src = $("#baseImage").attr("src");

                  //This code is wrapped in the .load function which is important.
                  //width and height of the object would return 0 if accessed before 
                  //the image gets loaded.
                  native_width = image_object.width;
                  native_height = image_object.height;
              }
              else
              {

                  var $this = $(this);
                  var thisPos = $this.position();
                  var parentPos = $('#baseImage').position();

                  var mx = thisPos.left - parentPos.left;
                  var my = thisPos.top - parentPos.top;
                  
                  
                  if ($("#scribe_zoom_box").is(":visible"))
                  {
                      //The background position of scribe_zoom_box will be changed according to the position
                      //of the mouse over the #baseImage image. So we will get the ratio of the pixel
                      //under the mouse pointer with respect to the image and use that to position the 
                      //large image inside the zoom box
                      var rx = (Math.round(mx/$("#baseImage").width()*native_width + ($("#baseImage").width()/2) - $("#scribe_zoom_box").width()/2)*-1)-150;
                      var ry = (Math.round(my/$("#baseImage").height()*native_height + ($("#baseImage").height()/2) - $("#scribe_zoom_box").height()/2))*-1;
                      
                      var bgp = rx + "px " + ry + "px";
                      //If you move the box over the image now, you should see the zoom box in action
                      $("#scribe_zoom_box").css("background-position", bgp);
               
                      
                  }
              }
           }
      });
  });
//end image zoom box

//build form for each transcription submission

  function addForm() 
  /*build form by appending elements to the container of "h4 Annotations", a div with id="annotateResults". Contains all the essential form elements
  and data for Rails model creation including an authenticity token. Rails variables passed to javascript by adding custom attributes such as "token"
  to html elements and grabbing their values using jquery. Modeled on the structure of another resulting html form created by rails functions in the
  "new.html.slim" file. In the "append" functions below, attributes are added as key: "value" pairs. Additional attributes for the form are added in
  the function that collects data from the transcription box after addForm() is called because they have illegal jquery chars (-) in the attribute
  name key and can only be passed as a string. */
  {

    
    var form = $('<form/>',
                 {
                    action: '/annotations',
                    class: "new_annotation",
                    id: "new_annotation" + annotationCount,
                    method: 'post'
                 }
    );
    var formDiv = $("<div/>", 
         { style:'margin:0; padding:0; display:inline;'}
    );
    //append characher encoding hidden field to the form. Rails models can only be created when set with a UTF-8 character encoding.
    formDiv.append($("<input/>", 
                       { 
                         name:'utf8', 
                         type:'hidden', 
                         value:'✓'                        }
                  ) );   
    var token = $('#annotateResults').attr('token'); /*grab authenticity token value from the "token" attribute on the div with id="annotateResults".
    Next, add the hidden field that holds the token value to the form */
    formDiv.append($("<input/>", 
                       { 
                         name:'authenticity_token', 
                         type:'hidden', 
                         value: token
                       }
               
                  ) );  
    form.append(formDiv);

    /*We're adding a form to create an annotation associated with a transcription that has not been created yet. In order to associate the newly
    created annotations with the future new transcription of the page we are on, the model instance ID of the last created transcription is passed
    to the forms for each field_group tab in the transcription box. When the user clicks on the tab for that field group (field_group), the form for
    that field_group is given the ID "currentForm" to identify it as the active form. Upon clicking the submit button in the transcription box, we
    get the ID of the most recent transription using the ruby code "Transcription.last" and increment it by one to associate our new annotation
    with the next created transcription (the one we have yet to submit on the current page). */
    var transcriptionId = $('#currentForm').attr('transcriptionCount');
    transcriptionId++;
    //Let's also get the ID of the field_group related to the current form and the page we are transcribing
    var field_groupId = $('#currentForm').attr('field_groupId');
    var pageId = $('#currentForm').attr('pageId');
    /*Append hidden fields to have the form automatically associate the annotation with the current (future) transcription, the field_group whose
    fields we are collecting data from, and the page that we are transcribing. */
    form.append(
       $("<input/>", 
           { 
             name:'annotation[field_group_id]', 
             type:'hidden', 
             value: field_groupId,
             id: 'annotation_field_group_id' 
           }
        )
    );
    form.append(
       $("<input/>", 
           { 
             name:'annotation[transcription_id]', 
             type:'hidden', 
             value: transcriptionId,
             id: 'annotation_transcription_id' 
           }
        )
    );
    form.append(
       $("<input/>", 
           { 
             name:'annotation[page_id]', 
             type:'hidden', 
             value: pageId,
             id: 'annotation_page_id' 
           }
        )
    );
    /*Append the field that will hold the JSON string passed to the form by the json grabber function. Data in this field will be passed to the
    new annotation's :data attribute upon form submission */
    form.append(
       $("<input/>", 
           { 
             name:'annotation[data]', 
             type:'text', 
             size: 30,
             id: formDataCount 
           }
        )
    );
    //Create the submit button
    form.append(
       $("<input/>", 
           { 
             name:'commit', 
             type:'submit', 
             value: 'Create Annotation' 
           }
        )
    );             
    //Finally, we add the form html stored in the variable "form" to the div with id="anotateResults"
    $("#annotateResults").append(form); 
    

  }
//end form

});