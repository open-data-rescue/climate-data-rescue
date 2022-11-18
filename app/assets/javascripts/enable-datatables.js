$(function() {
	$(".datatables")
		.css({display: 'block'})
		.DataTable({
			drawCallback: function() {
				$("img.lazyload").lazyload();
			}
		});
});
