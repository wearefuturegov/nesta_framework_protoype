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

  $('.card_sort_single').click(function() {
    if ($(this).hasClass('selected')) {
      $(this).removeClass('selected');
      cardsLeft++;
    } else {
      if(cardsLeft != 0) {
        cardsLeft--;
        $(this).addClass('selected');
      }
    }
    $('.card_sort_footer .num_left').html(cardsLeft);

    if (cardsLeft == 0) {
      $('.card_sort_footer .actions').slideDown(300);
      $('.next_button').removeClass('disabled');
    } else {
      $('.card_sort_footer .actions').slideUp(300);
      $('.next_button').addClass('disabled');
    }
  });
};
