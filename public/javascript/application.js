$(document).ready( function() {

  $.ajaxSetup({ cache: true });

  // any external links open in a new tab/window
  $(document.links).filter(function() {
      return this.hostname != window.location.hostname;
  }).attr('target', '_blank');

});

var showOverlay = function(){
  $('#overlay').removeClass('hidden');
};

var displayCardInfo = function(card_id){
  var current = $('#current-card-info').data('id');
  if(current === card_id) { return } 
   
  displayAjaxLoader('.card-info');
  $.ajax({
    url: 'card_info/' + card_id, 
    type: 'POST',
    success: function(data) {
      $('.card-info').html(data);
    }
  });
};

var displayAjaxLoader = function(element){
  $(element).html(
    '<div class="ajax-loader"><img src="/images/ajax-loader.gif"></div>'
  )
};
