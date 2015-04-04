$(document).ready( function() {

  $(document.links).filter(function() {
      return this.hostname != window.location.hostname;
  }).attr('target', '_blank');

});

var showOverlay = function(){
  $('#overlay').removeClass('hidden');
};

var displayCardInfo = function(card_id){
  var current = $('#current-card-info').data('id');

  if(current === card_id){
    return
  } else {
    displayAjaxLoader('.card-info');
    $('.card-info').load(
      'card_info', {'id': card_id}
    );
  }
};

var displayAjaxLoader = function(element){
  $(element).html(
    '<div class="ajax-loader"><img src="/images/ajax-loader.gif"></div>'
  )
};
