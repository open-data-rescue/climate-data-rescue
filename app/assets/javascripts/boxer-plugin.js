
 // Boxer plugin
// sourced from http://jsbin.com/azare/edit?html,js,output


$.widget("ui.boxer", $.ui.mouse, {
    _init: function() {
        this.element.addClass("ui-boxer");
        this.dragged = true;
        this._mouseInit();
        this.helper = $('<div></div>')
            .addClass("annotation-marker helper");
      
    },

    destroy: function() {
       
        this.element
            .removeClass("ui-boxer ui-boxer-disabled")
            .removeData("boxer")
            .unbind(".boxer");
        this._mouseDestroy();

        return this;
    },

    _mouseStart: function(event) {
        var self = this;
        var options = this.options;
        var target = options.target || options.appendTo;
        var groupColour = "";
        
        if (!(typeof(options.groupColour) == "undefined")) {
            groupColour = options.groupColour;
        };

        var offset = $(target).offset();

        var position = {
          x: event.pageX - $(document).scrollLeft() - offset.left,
          y : event.pageY - $(document).scrollTop() - offset.top
        };

        this.opos = [position.x, position.y];

        if (this.options.disabled)
            return;

        

        this._trigger("start", event);

        $(options.appendTo).append(this.helper);

        this.helper.css({
            "left": position.x,
            "top": position.y,
            "width": 0,
            "height": 0
        }).addClass(groupColour);
    },

    _mouseDrag: function(event) {
      
        var self = this;
        this.dragged = true;

        if (this.options.disabled)
            return;

        var options = this.options;
        var target = options.target || options.appendTo;
        
        var $container = $(options.container);
        
        if (event.pageX > ($container.width() - 50)) {
            $container.scrollLeft($container.scrollLeft() + 5); 
        } else if (event.pageX < ($container.offset().left + 50)) {
            $container.scrollLeft($container.scrollLeft() - 5);
        };
        
        if (event.pageY > ($container.height() - 50)) {
            $container.scrollTop($container.scrollTop() + 5); 
        } else if (event.pageY < ($container.offset().top + 50)) {
            $container.scrollTop($container.scrollTop() - 5);
        };

        
        var position = {
          x: event.pageX - $(document).scrollLeft() - $(target).offset().left,
          y : event.pageY - $(document).scrollTop() - $(target).offset().top
        };

        var x1 = this.opos[0], y1 = this.opos[1], x2 = position.x, y2 = position.y;
        if (x1 > x2) { var tmp = x2; x2 = x1; x1 = tmp; }
        if (y1 > y2) { var tmp = y2; y2 = y1; y1 = tmp; }

        this.helper.css({left: x1, top: y1, width: x2-x1, height: y2-y1});
        
        this._trigger("drag", event);

        return false;
    },

    _mouseStop: function(event) {
          
        var self = this;

        this.dragged = false;

        var options = this.options;

        var clone = this.helper.clone().appendTo(this.element).removeClass("helper");
     

        this._trigger("stop", event, { box: clone });

        this.helper.remove(); 
    
        return false;
      
    }

});
$.extend($.ui.boxer, { 
    defaults: $.extend({}, $.ui.mouse.defaults, {
        appendTo: 'body',
        distance: 0
    })
});


