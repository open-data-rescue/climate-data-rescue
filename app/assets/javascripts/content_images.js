$(document).ready(function() {
    var clipboard = new Clipboard('.url-btn');

    clipboard.on('success', function(e) {
        var $elem = $(e.trigger);
        $elem.tooltip({
            title : "Copied!"
        });
        $elem.tooltip("show");
        $elem.on("mouseout", function() {
            if ($elem.data && $elem.data('bs.tooltip')){
                $elem.tooltip("destroy");
            };
        });
        e.clearSelection();
    });

    
});