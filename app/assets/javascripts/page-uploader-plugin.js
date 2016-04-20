

(function($){
	$.widget("climate.pageUploader", {
		
		/*
         * 
         */
        options : {
            add_param : false,
            redirect_url : '/',
            submit_fn : null,
            complete_fn : null,
            delete_fn : null,
            fail_fn : null,
            always_fn : null,
            max_number : 1,
            auto : true,
            
        },
        
        /*
         * 
         */
        _create : function() {
            var redirect_to = this.options.redirect_url;
            var submit_fn = this.options.submit_fn;
            var complete_fn = this.options.complete_fn;
            var delete_fn = this.options.delete_fn;
            var fail_fn = this.options.fail_fn;
            var always_fn = this.options.always_fn;
            var max_number = this.options.max_number;
            var auto = this.options.auto;
            this.element.fileupload({
                maxNumberOfFiles : max_number,
                autoUpload : auto
            }).bind('fileuploadsubmit', function (e, data){
                if (submit_fn) {
                    submit_fn();
                }
            }).bind('fileuploadprogress', function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $(data.context).find('.progress-bar').css(
                    'width',
                    progress + '%'
                );
            }).bind('fileuploadfailed', function(e,data) {
                // alertMessageJson(data.jqXHR.responseJSON);
                if (fail_fn) {
                    fail_fn(data);
                }
            }).bind('fileuploadalways', function(e,data) {
                if (always_fn) {
                    always_fn();
                }
            }).bind('fileuploadcompleted', function(e,data) {
                if (complete_fn) {
                    complete_fn();
                }
            }).bind('fileuploaddestroy', function(e,data) {
                if (delete_fn) {
                    delete_fn(data);
                }
            });
            
        }
	});
})(jQuery);
