$(document).ready( function() {

  $('.before-click').on('click', function() {
    $(this).addClass('hidden');
    $(this).siblings('.after-click').removeClass('hidden');
  });

});
