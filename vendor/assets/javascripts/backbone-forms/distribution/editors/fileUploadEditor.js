;(function(Form) {

Form.editors.File = Form.editors.Text.extend({

    uploadFile: function(ev) {
        var i = 0, files = this.files,
        len = files.length;
        console.log(files);
        ev.data.$the_file = files[0];
        ev.data.$el.find('#file_preview').text(ev.data.$the_file.name);
    }, 

    initialize: function(options) {
        options = options || {};
        
        Form.editors.Base.prototype.initialize.call(this, options);
        
        this.schema = _.extend({}, options.schema || {});
        
        this.template = options.template || this.constructor.template;
    },

    render: function() {
        var $el = $($.trim(this.template({
                field_name : this.key
            })));
        this.setElement($el);

        $el.find('input[type=file]').on('change input[type=file]', this, this.uploadFile);

        this.$the_file = '';

        return this;
    },

    getValue: function() {
        var val = this.$the_file;
        return val;
    },

}, {
    // Also may be good to add progress bar
    template: _.template('\
            <div>\
                <span class="btn btn-success fileinput-button">\
                    <span>Select file ...</span>\
                    <input class="col-sm-10" type="file" id="<%= field_name %>" name="files[]"/>\
                </span>\
                <div class="progress progress-striped active">\
                    <div class="progress-bar progress-bar-success" role="progressbar" style="width:0%;"></div>\
                 </div>\
                 <div class="file-upload-name" id="file_preview"></div>\
         </div>\
        ', null, Form.templateSettings),
});


/*
 * An image field for Cloudinary.
 */
Form.editors.FileUpload = Form.editors.Text.extend({
    
    initialize: function(options) {
        options = options || {};
        
        Form.editors.Base.prototype.initialize.call(this, options);
        
        this.schema = _.extend({ // Pass in extra options for the datetime as part of the schema
        }, options.schema || {});
        
        this.template = options.template || this.constructor.template;
    },
    
    render: function() {
        var $el = $($.trim(this.template({
                field_name : this.key,
                handler : this.schema.handler
            })));
        this.setElement($el);
        
        var element = this.$el;
        var field_name = this.key;
        element.find('#' + field_name + '_preview').text(this.value);
        
        element.find('#' + field_name).fileupload({
            dataType: 'json',
            replaceFileInput : false,
            add : function(e, data) {
                data.context = element.find('#' + field_name + '_preview').text('Uploading...');
                data.submit();
            },
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    element.find('#' + field_name + '_preview').text(file.name.split('\\').pop().split("/").pop());
                });
            }
        });

        return this;
    },
    
    getValue: function() {
        return this.$el.find("#" + this.key).val();
    },
     
    setValue: function(val) {
        this.$el.find("#" + this.key).val(val);
    }
    
}, {
    template: _.template('\
            <span>\
            <div class="upload_button_holder">\
                <input id="<%= field_name %>" type="file" name="files[]" data-url="<%= handler %>" >\
                <span class="status"></span>\
                <div id="<%= field_name %>_preview"></div>\
            </div>\
            </span>\
        ', null, Form.templateSettings),
});

})(Backbone.Form);
