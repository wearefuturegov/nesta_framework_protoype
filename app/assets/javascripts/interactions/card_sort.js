$.fn.cardSort = function(options) {
  if (this.length === 0) { return false; }

  var settings = $.extend({
    noOfCards: 14,
    noToChoose: 5,
    type: 'cards_sort_1',
    type_text: "skills"
  }, options );

  var selectedCards = $('.card_sort_single.selected').length;
  var cardsLeft = selectedCards == 0 ? settings.noToChoose : (settings.noToChoose - selectedCards);

  var hideShowFooter = function() {
    if (cardsLeft == 0) {
      $('.card_sort_footer .actions').slideDown(300, function() {
        $('footer').css('margin-bottom', $('.card_sort_footer').height()+40);
      });
      $('.next_button').removeClass('disabled');
    } else {
      $('.card_sort_footer .actions').slideUp(300, function() {
        $('footer').css('margin-bottom', $('.card_sort_footer').height()+40);
      });
      $('.next_button').addClass('disabled');
    }
  }

  hideShowFooter();

  $('.card_sort_footer .num_left').html(cardsLeft);
  $('.card_sort_footer .card_type').html(settings.type_text);
  for (var i = 1; i < (cardsLeft+1); i++) {
    $('.card_sort_footer #status_indicator').prepend('<div id="indicator_'+ i +'" class="indicator"></div>');
  }

  $('.card_sort_single label').click(function() {
    var $parent = $(this).parent('div');
    if ($parent.hasClass('selected')) {
      cardsLeft++;
      $('#indicator_'+cardsLeft).removeClass('working_together');
      $('#indicator_'+cardsLeft).removeClass('leading_change');
      $('#indicator_'+cardsLeft).removeClass('accelerating_learning');
      $('#indicator_'+cardsLeft).removeClass('attitude');
      $parent.removeClass('selected');
      $(this).children('input')[0].checked = false;
    } else {
      if(cardsLeft != 0) {
        $('#indicator_'+cardsLeft).addClass($parent.data('type'));
        cardsLeft--;
        $parent.addClass('selected');
        $(this).children('input')[0].checked = true;
      }
    }
    $('.card_sort_footer .num_left').html(cardsLeft);

    hideShowFooter();
    return false;
  });


  $('footer').css('margin-bottom', $('.card_sort_footer').height()+40);
};
