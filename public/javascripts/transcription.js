function initialise_drag_box() {
    var fieldgroups_count = $('.transcription_fieldgroups').length;
    var drag_box_id = fieldgroups_count;
    $('#transcription_image').imgAreaSelect({
        handles: true,
        areaId: drag_box_id,
        onSelectEnd: function render_options(img, box) {
            $.post(
                '/transcriptions/add_fieldgroups', {
                    x1: box.x1,
                    y1: box.y1,
                    x2: box.x2,
                    y2: box.y2,
                    count: fieldgroups_count
                }
            );
        }
    });
}

function render_options(img, box) {
    alert(val(box.x1));
}

function remove_transcription_fieldgroups(element) {
    $(element).remove();
}