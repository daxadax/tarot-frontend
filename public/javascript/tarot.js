$(document).ready( function() {

  $('.card').mousedown(function() {
    var data = $(this).data();

    $('#spread li.active').removeClass('active');
    $(this).addClass('active');

    $('.sidebar-card-info').load(
      'card_info?' + $.param({ card: data })
    );
  });

});