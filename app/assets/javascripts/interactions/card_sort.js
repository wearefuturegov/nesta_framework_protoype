$.fn.cardSort = function(options) {
  if (this.length === 0) { return false; }

  var settings = $.extend({
    noOfCards: 14,
    noToChoose: 5,
    type: 'cards_sort_1',
    type_text: "skills"
  }, options );

  var cardsLeft = settings.noToChoose;

  $('.card_sort_footer .num_left').html(cardsLeft);
  $('.card_sort_footer .card_type').html(settings.type_text);

  $('.card_sort_single label').click(function() {
    var $parent = $(this).parent('div');
    if ($parent.hasClass('selected')) {
      $parent.removeClass('selected');
      cardsLeft++;
      $(this).children('input')[0].checked = false;
    } else {
      if(cardsLeft != 0) {
        cardsLeft--;
        $parent.addClass('selected');
        $(this).children('input')[0].checked = true;
      }
    }
    $('.card_sort_footer .num_left').html(cardsLeft);

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

    return false;
  });


  $('footer').css('margin-bottom', $('.card_sort_footer').height()+40);
};
