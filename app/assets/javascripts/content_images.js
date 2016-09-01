$(document).ready(function() {
    var clipboard = new Clipboard('.url-btn');

    clipboard.on('success', function(e) {
        $(e.trigger).tooltip("show");
        $(e.trigger).on("mouseout", function() {
            $(e.trigger).tooltip("destroy");
            $(e.trigger).off();
        });
        e.clearSelection();
    });

    
});