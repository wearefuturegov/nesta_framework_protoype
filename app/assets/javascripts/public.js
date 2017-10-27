$(document).ready(function() {

  $('.accordion').accordion();

  $('#cards_sort_1').cardSort({
    noOfCards: 14,
    noToChoose: 5,
    type: "strongest skills"});

});
