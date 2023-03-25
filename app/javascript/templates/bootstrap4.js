/**
 * Include this template file after backbone-forms.amd.js to override the default templates
 *
 * 'data-*' attributes control where elements are placed
 */
//;(function(root) {
//})(window || global || this);

;(function(Form) {

  var sharedTemplateData = function() {
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

  Form.Field.prototype.templateData = sharedTemplateData;

  Form.NestedField.prototype.templateData = sharedTemplateData;

  Form.modalTemplate = _.template('\
    <div class="modal-dialog modal-lg">\
      <div class="modal-content">\
        <% if (title) { %>\
          <div class="modal-header">\
            <h3><%= title %></h3>\
            <% if (allowCancel) { %>\
              <a class="close">×</a>\
            <% } %>\
          </div>\
        <% } %>\
        <div class="modal-body"><%= content %></div>\
        <% if ((typeof showFooter !== "undefined") && showFooter) { %>\
          <div class="modal-footer">\
            <% if (allowCancel) { %>\
              <% if (cancelText) { %>\
                <a href="#" class="btn cancel"><%= cancelText %></a>\
              <% } %>\
            <% } %>\
            <a href="#" class="btn ok btn-primary"><%= okText %></a>\
          </div>\
        <% } %>\
      </div>\
    </div>\
  ');


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
            <i class='glyphicon glyphicon-info-sign bpopover' title='<%= title %>' data-container='body' data-trigger='hover' data-placement='<%= help_placement %>' data-toggle='popover' data-content='<%= help %>'></i>\
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
        <% if (help && (help.length > 0) ) { %>\
            <i class="glyphicon glyphicon-info-sign bpopover" title="<%- title %>" data-container="body" data-trigger="hover" data-placement="<%= help_placement %>" data-toggle="popover" data-content="<%= help %>"></i>\
        <% }; %>\
      </label>\
      <div title="<%- title %>" class="input-xlarge">\
        <div data-editor></div>\
        <p class="help-block" data-error></p>\
        <p class="help-block"><%= hint %></p>\
      </div>\
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
