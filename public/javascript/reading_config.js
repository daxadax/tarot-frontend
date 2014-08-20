$(document).ready( function() {

  $('.uniq-btn').mousedown(function(){
    $(this).siblings().removeClass('active');
    handleActiveClass($(this));
  });

  $('.vulgar-btn').mousedown(function(){
    handleActiveClass($(this));
  });

  $('.top-lvl').click(function(){
    showPaneAt('100%');
  });

  $('.card').click(function(){
    var confirmButton = $('.imported-reading').find('.confirm');

    if(cardsLeftToPick() != 0){
      confirmButton.addClass('hidden');
      showRequirementsFor('imported-reading');
    } else {
      confirmButton.removeClass('hidden');
    };
  });

  $('.deck-container').find('.deck').mousedown(function(){
    handleDeckInfo($(this));
    $('.deck-container').find('.confirm').removeClass('hidden');
  });

  $('.spread-container').find('.spread').mousedown(function(){
    handleSpreadInfo($(this));
    $('.spread-container').find('.confirm').removeClass('hidden');
  });

  $('.deck-container').find('.confirm').mousedown(function(){
    showPaneAt('200%');
  });

  $('.spread-container').find('.btn').mousedown(function(){
    $('.spread-container').find('.confirm').removeClass('hidden');
  });

  $('.spread-container').find('.confirm').mousedown(function(){
    if(activeRequestType() == 'new-reading'){
      sendNewRequest();
    } else {
      showRequirementsFor('imported-reading');
      showPaneAt('300%');
    };
  });

  $('.imported-reading').find('.confirm').mousedown(function(){
    window.location.href = buildUrlForImportedReading();
  });

  var sendNewRequest = function(){
    var url = '/reading?deck=' + activeDeckName()
                  + '&spread=' + activeSpreadName();

    window.location.href = url;
  };

  var activeRequestType = function(){
    return $('.top-lvl-buttons').find('.top-lvl.active').data('name');
  };

  var activeDeckName = function(){
    return $('.global-options').find('.deck.active').data('name');
  };

  var activeSpreadName = function(){
    return $('.global-options').find('.spread.active').data('name');
  };

  var numberOfCardsForActiveSpread = function(){
    return $('.global-options').find('.spread.active').data('number');
  };

  var arrayOfChosenCards = function(){
    var cards   = $('.card').filter('.active').map(function(){
      return [$(this).data('id')];
    }).get();

    return cards;
  };

  var buildUrlForImportedReading = function(){
    var stringyCards = JSON.stringify(arrayOfChosenCards());

    return '/reading?deck='           + activeDeckName()
                + '&spread='          + activeSpreadName()
                + '&specified_cards=' + stringyCards;
  };

  var handleActiveClass = function(el){
    el.hasClass('active') ? el.removeClass('active') : el.addClass('active');
  };

  var handleDeckInfo = function(el){
    if(el.hasClass('active')) {
      loadDeckInfo();
      $('.deck-info-container').removeClass('hidden');
    } else {
      $('.deck-info-container').addClass('hidden');
    }
  };

  var loadDeckInfo = function(){
    $.get('deck_info/' + activeDeckName(), function(data){
      $('.deck-info-container').find('.deck-info').html(data);
    });
  }

  var handleSpreadInfo = function(el){
    if(el.hasClass('active')) {
      loadSpreadInfo();
      $('.spread-info-container').removeClass('hidden');
    } else {
      $('.spread-info-container').addClass('hidden');
    }
  };

  var loadSpreadInfo = function(){
    $.get('spread_info/' + activeSpreadName(), function(data){
      $('.spread-info-container').find('.spread-info').html(data);
    });
  }


  var showPaneAt = function(percent){
    $('.configuration-ribbon').css({'right': percent});
  };

  var cardsLeftToPick = function(){
    return numberOfCardsForActiveSpread() - arrayOfChosenCards().length;
  };

  var showRequirementsFor = function(className){
    $('.' + className).find('.requirements').html(requirementsFor(className));
  };

  var requirementsFor = function(className){
    var cardsLeft       = Math.abs(cardsLeftToPick()),
        grammarQuantity = cardsLeftToPick() > 0 ? "more " : "fewer ",
        grammarCard     = cardsLeft == 1 ? "card" : "cards";

    if(className === 'imported-reading'){
      return 'This spread requires <div class ="number">'
              + cardsLeft + '</div>'
              + grammarQuantity + grammarCard
    }
  };

});