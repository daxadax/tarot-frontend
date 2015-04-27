$(document).ready( function() {

  $('#content').on('click', '.card', function() {
    var card_id = $(this).data('cardId'),
          image_path = $(this).data('imagePath');

    if( card_id === undefined ){
      return false;
    } else {
      showOverlay();
      displayCardInfo(card_id);
      showLargeCard(image_path);
    }
  })

  $(document).on('keydown', function(key){
    if (key.keyCode === 27){
      hideLargeCard();
    };
  });

  var hideLargeCard = function(){
    $('#large-card').addClass('hidden');
  };

  var showLargeCard = function(image_path){
    $('#large-card').html( image_path ).removeClass( 'hidden' );
  };

});
