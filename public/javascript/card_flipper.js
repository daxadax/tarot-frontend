$(document).ready( function() {
  var cards = $('#spread').data('cards'),
    clickCount = 0;

  $('#unseen-cards').on('mousedown', function() {
    var card_id = cards.pop();
    if(card_id === undefined) { return };   

    displayCardInfo(card_id);
    showOverlay();
    clickCount ++
    flipCard(card_id, clickCount);
    $('#content').find('.position-' + clickCount).removeClass('hidden');
  });

  var flipCard = function(card_id, index){
    $.ajax({
      url: 'card_for_spread/' + card_id,
      dataType: 'html',
      success: function(result){
        $('.active').removeClass('active'); 
        $('#cards-holder').append(
          "<div class= 'position-"+ index +" inline-block active' >" + result + "</div>"
        )
      }
    })
  };

});
