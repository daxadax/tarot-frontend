$(document).ready( function() {

  $('.card').mousedown(function() {
    var data = $(this).data();

    if( data.id === undefined ){
      return false;
    } else {
      showOverlay();
      displayCardInfo(data);
    }
  })

  $('.back-to-spread').mousedown(function() {
    hideOverlay();
  });

  $('.badges').find('[class$=button]').mousedown(function(){
    var buttonName = $(this).attr('class')

    if($(this).next().hasClass('hidden')) {
      allBadgeInfo = $('.badges').find('[class$=info]')

      allBadgeInfo.addClass('hidden');
      $(this).next().removeClass('hidden');
    } else {
      $(this).next().addClass('hidden');
    }
  });

  var showOverlay = function(){
    $('#overlay').removeClass('hidden');
  };

  var hideOverlay = function(){
    $('#overlay').addClass('hidden');
  };

  var displayCardInfo = function(card_data){
    $('.card-info').load(
      'card_info', {card: card_data}
    );
  };

});




