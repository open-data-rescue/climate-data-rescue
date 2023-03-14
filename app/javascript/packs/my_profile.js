import 'bootstrap'


var currentPage = 1;
var perPage = 20;
$('#toggle-completed-transcriptions').tooltip();
$('#completed-transcriptions-container').on('hide.bs.collapse', function () {
  $('#toggle-completed-transcriptions > i').removeClass('fa-caret-up').addClass('fa-caret-down');
}).on('show.bs.collapse', function () {
  $('#toggle-completed-transcriptions > i').removeClass('fa-caret-down').addClass('fa-caret-up');
  loadTranscriptions();
});

$('.transcription-paginator li a').click(function(e) {
  e.preventDefault();
  e.stopPropagation();
  var page = $(e.target).data('page');
  console.log(e.target, page)
  if ($(e.target).hasClass('active')) { return; }

  if (page == 'first') {
    var $current = $('.transcription-paginator li[data-page=' + page + ']');
    $current.siblings().removeClass('active');
    $current.siblings('.real-page').first().addClass('active');
    setCurrentPage(1);
  }
  else if (page == 'last') {
    var $current = $('.transcription-paginator li[data-page=' + page + ']');
    $current.siblings().removeClass('active');
    var $last = $current.siblings('.real-page').last();
    $last.addClass('active');
    setCurrentPage($last.data('page'));
  }
  else {
    setPaginationActiveState(page);
  }
});

function setPaginationActiveState(page) {
  var current = $('.transcription-paginator li[data-page=' + page + ']');
  current.siblings().removeClass('active');
  current.addClass('active');
  setCurrentPage(page)
}

function setCurrentPage(page) {
  currentPage = page;
  loadTranscriptions();
}

function loadTranscriptions() {
  $('#transcription-ajax-target').html('<i class="fa fa-refresh fa-spin fa-3x"></i>');
  $.ajax({
    url: "#{completed_transcriptions_user_path(@user)}",
    data: {
      page: currentPage,
      per_page: perPage
    }
  }).done(function(data) {
    $('#transcription-ajax-target').html(data);
  })
  .fail(function(xhr) {
    $('#transcription-ajax-target').html("Could not load completed transcriptions. Please try again, or report this to the DRAW administrators if the problem persists.");
  });
}
