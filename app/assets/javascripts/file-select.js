$(document).on('turbolinks:load', function() {
  $(document).on('change', ':file', function() {
    var input = $(this),
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    var text_box = input.parents('.input-group').find(':text');
    text_box.val(label);
  });
})