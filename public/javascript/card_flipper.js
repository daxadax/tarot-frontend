$(document).ready( function() {
  var cards = $('#spread').data('cards'),
      symbols = $('#spread').data('availableSymbols'),
      clickCount = 0;

  $('#unseen-cards').on('mousedown', function() {
    var card_id = cards.pop();
    if(card_id === undefined) { return };

    if(clickCount === 0) { $(calculateSymbolTally('.influences')) }
    
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
        );
        calculateSymbolTally('.card-info');
      }
    })
  };

  var calculateSymbolTally = function(range) {
    $.each(symbols, function(symbol_index, symbol){
      tallySymbol(range, symbol);
    });
  };

  var tallySymbol = function(range, symbol) {
    var newCount = getNewCount(range, symbol);
    if( newCount == 0 ) { return } 
    
    addCountToSymbol(symbol, newCount);
  };

  var addCountToSymbol = function(symbol, count) {
    var holder = $('.symbol-tally').find('.' + symbol),
        oldCount = fetchOldCount(holder);

    unhide(holder);
    totalCount = buildTotalCount(count, oldCount);
    holder.find('.count').html(totalCount);
  };

  var fetchOldCount = function(element) {
    return parseInt(element.find('.count').html()) || 0;
  };

  var buildTotalCount = function(newCount, oldCount) {
    return oldCount + newCount
  };

  var unhide = function(element) {
    if(element.hasClass('hidden')) { 
      element.removeClass('hidden') 
    }
  };

  var getNewCount = function(range, symbol) {
    var count = $(range).find('.symbol-' + symbol).length;
    return parseInt(count);
  };
});
