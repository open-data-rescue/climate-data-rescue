
 // Boxer plugin
// sourced from http://jsbin.com/azare/edit?html,js,output


$.widget("ui.boxer", $.ui.mouse, {
	_init: function() {
  
		this.element.addClass("ui-boxer");
		this.dragged = true;
		this._mouseInit();
		this.helper = $('<div></div>')
			.css({border:'2px dotted black', background:"#A95EFF", opacity:"0.3"})
			.addClass("annotation-marker");
      
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

        var offset = $(options.appendTo).offset();

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
			"z-index": 100,
			"position": "absolute",
			"left": position.x,
			"top": position.y,
			"width": 0,
			"height": 0
		});
	},

	_mouseDrag: function(event) {
      
        var self = this;
		this.dragged = true;

		if (this.options.disabled)
			return;

		var options = this.options;
        
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
	      x: event.pageX - $(document).scrollLeft() - $(options.appendTo).offset().left,
	      y : event.pageY - $(document).scrollTop() - $(options.appendTo).offset().top
	    };

		var x1 = this.opos[0], y1 = this.opos[1], x2 = position.x, y2 = position.y;
		if (x1 > x2) { var tmp = x2; x2 = x1; x1 = tmp; }
		this.helper.css({left: x1, top: y1, width: x2-x1, height: y2-y1});
		
		this._trigger("drag", event);

		return false;
	},

	_mouseStop: function(event) {
//       alert('stop');
          
		var self = this;

		this.dragged = false;

		var options = this.options;

		var clone = this.helper.clone()
      //.removeClass('ui-boxer-helper')
			.appendTo(this.element);
     

		this._trigger("stop", event, { box: clone });

		    this.helper.remove(); 
    //$( "div" ).remove( ".ui-boxer-helper" );
    
		return false;
      
      
	}

});
$.extend($.ui.boxer, { 
	defaults: $.extend({}, $.ui.mouse.defaults, {
		appendTo: 'body',
		distance: 0
	})
});


