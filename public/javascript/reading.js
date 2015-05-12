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
      shrinkCardInfo();
    }
  })

  $(document).on('keydown', function(key){
    if (key.keyCode === 27){
      hideLargeCard();
      resizeCardInfo();
    };
  });

  var shrinkCardInfo = function(){
    $('.card-info').addClass('absolute')
    $('.card-info').css('width', '49%')
  }

  var resizeCardInfo = function(){
    $('.card-info').removeClass('absolute')
    $('.card-info').css('width', '75%')
  }

  var hideLargeCard = function(){
    $('#large-card').addClass('hidden');
  };

  var showLargeCard = function(image_path){
    $('#large-card').html( image_path ).removeClass( 'hidden' );
  };

});
