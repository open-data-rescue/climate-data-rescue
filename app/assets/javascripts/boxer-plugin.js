
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
        this.zoomLevel = options.zoomLevel || 1;
        
        if (options.groupColour) {
            groupColour = options.groupColour;
        };

        var offset = $(target).offset();

        this.startPosition = {
          x: (event.pageX / this.zoomLevel) - $(document).scrollLeft() - offset.left,
          y: (event.pageY / this.zoomLevel) - $(document).scrollTop() - offset.top
        };

        if (this.options.disabled)
            return;

        this._trigger("start", event);

        $(options.appendTo).append(this.helper);

        this.helper.css({
            "left": this.startPosition.x,
            "top": this.startPosition.y,
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

        // Adjust page co-ordinates to account for zoom level
        var pageX = (event.pageX / this.zoomLevel);
        var pageY = (event.pageY / this.zoomLevel);
        
        // Scroll the container when dragging near the edges
        if (pageX > ($container.width() - 50)) {
            $container.scrollLeft($container.scrollLeft() + 5); 
        } else if (pageX < ($container.offset().left + 50)) {
            $container.scrollLeft($container.scrollLeft() - 5);
        };
        
        if (pageY > ($container.height() - 50)) {
            $container.scrollTop($container.scrollTop() + 5); 
        } else if (pageY < ($container.offset().top + 50)) {
            $container.scrollTop($container.scrollTop() - 5);
        };

        var currentPosition = {
          x: pageX - $(document).scrollLeft() - $(target).offset().left,
          y: pageY - $(document).scrollTop() - $(target).offset().top
        };

        var x1 = this.startPosition.x, y1 = this.startPosition.y, x2 = currentPosition.x, y2 = currentPosition.y;

        // Support dragging in both directions
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


