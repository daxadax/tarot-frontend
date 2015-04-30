$(document).ready( function() {

  $('.before-click').on('click', function() {
    $(this).hide();
    $(this).siblings('.after-click').removeClass('hide');
  });

});
