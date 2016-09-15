/** 
 * Include this template file after backbone-forms.amd.js to override the default templates
 * 
 * 'data-*' attributes control where elements are placed
 */
//;(function(root) {
//})(window || global || this);

;(function(Form) {

  Form.Field.prototype.templateData = function() {
    var schema = this.schema;

    return {
      help: schema.help || '',
      help_placement: schema.help_placement || 'auto',
      hint: schema.hint || '',
      title: schema.title,
      fieldAttrs: schema.fieldAttrs,
      editorAttrs: schema.editorAttrs,
      key: this.key,
      editorId: this.editor.id
    };
  };


  /**
   * Bootstrap 3 templates
   */
  Form.template = _.template('\
    <form class="form-horizontal" role="form" data-fieldsets></form>\
  ');


  Form.Fieldset.template = _.template('\
    <fieldset data-fields>\
      <% if (legend) { %>\
        <legend><%= legend %></legend>\
      <% } %>\
    </fieldset>\
  ');


  Form.Field.template = _.template("\
    <div class='form-group field-<%= key %>'>\
      <label class='col-sm-4 control-label' for='<%= editorId %>'>\
        <%= title %>\
        <% if (help && (help.length > 0) ) { %>\
            <i class='glyphicon glyphicon-info-sign' title='<%= title %>' data-container='body' data-trigger='hover' data-placement='<%= help_placement %>' data-toggle='popover' data-content='<%= help %>'></i>\
        <% }; %>\
      </label>\
      <div class='col-sm-8'>\
        <div data-editor></div>\
        <p class='help-block'><%= hint %></p>\
        <p class='help-block' data-error></p>\
      </div>\
    </div>\
  ");

  Form.NestedField.template = _.template('\
    <div class="field-<%= key %>">\
      <label for="<%= editorId %>">\
        <%= title %>\
      </label>\
      <div title="<%= title %>" class="input-xlarge">\
        <span data-editor></span>\
        <div class="help-inline" data-error></div>\
      </div>\
      <div class="help-block"><%= help %></div>\
    </div>\
  ');

  Form.editors.Base.prototype.className = 'form-control';
  Form.Field.errorClassName = 'has-error';

  if (Form.editors.List) {

    Form.editors.List.template = _.template('\
      <div class="bbf-list">\
        <ul class="list-unstyled clearfix" data-items></ul>\
        <button type="button" class="btn bbf-add" data-action="add">Add</button>\
      </div>\
    ');


    Form.editors.List.Item.template = _.template('\
      <li class="clearfix">\
        <div class="pull-left" data-editor></div>\
        <button type="button" class="btn bbf-del" data-action="remove">&times;</button>\
      </li>\
    ');
    

    Form.editors.List.Object.template = Form.editors.List.NestedModel.template = _.template('\
      <div class="bbf-list-modal"><%= summary %></div>\
    ');

  };

})(Backbone.Form);
