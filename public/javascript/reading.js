$(document).ready( function() {

  $('#content').on('click', '.card', function() {
    var card_id = $(this).data('cardId'),
        image_path = $(this).data('imagePath'),
        cardSlot = $(this).parent();

    if( card_id === undefined ) { return } 
    showOverlay();
    activate(cardSlot, card_id, image_path);
    showLargeCard();
    shrinkCardInfo();
  })

  $(document).on('keydown', function(key){
    if (key.keyCode === 27){ // escape
      hideLargeCard();
      resizeCardInfo();
    };
    if (key.keyCode === 13) { // enter
      // triggers the card flipper stack
      // feels dirty, but it's just so easy 
      $('#unseen-cards').mousedown();  
    };
    if (key.keyCode === 37) { // left arrow
      card = activeCard().prev()
      viewCard(card);
    };
    if (key.keyCode === 39) { // right arrow
      card = activeCard().next()
      viewCard(card);
    };
  });

  var viewCard = function(card) {
    var card_id = card.find('.card').data('cardId'),
        image_path = card.find('.card').data('imagePath');
   
    if(card.attr('class') === undefined) { return }
    activate(card, card_id, image_path);
  };

  var activeCard = function(){
    return $('#cards-holder .active');
  };

  var activate = function(cardSlot, card_id, image_path){
    $('.active').removeClass('active');
    cardSlot.addClass('active');
    updateCardImage(image_path);
    displayCardInfo(card_id);
  };

  var shrinkCardInfo = function(){
    $('.card-info').addClass('absolute')
    $('.card-info').css('width', '55%')
  };

  var resizeCardInfo = function(){
    $('.card-info').removeClass('absolute')
    $('.card-info').css('width', '75%')
  };

  var updateCardImage = function(image_path){
    $('#large-card').html( image_path );
  }

  var hideLargeCard = function(){
    $('#large-card').addClass('hidden');
  };

  var showLargeCard = function(){
    $('#large-card').removeClass('hidden');
  };

});
