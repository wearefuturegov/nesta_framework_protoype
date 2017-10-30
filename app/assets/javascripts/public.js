$(document).ready(function() {

  $('.disabled').click(function(e){ if($(this).hasClass('disabled')){ e.preventDefault(); }});
  $('.accordion').accordion();

  $('#cards_sort_1').cardSort({
    noOfCards: 14,
    noToChoose: 5,
    type: "strongest skills"});

  $('#cards_sort_2').cardSort({
    noOfCards: 9,
    noToChoose: 3,
    type: "weakest skills"});

  $('#cards_sort_3').cardSort({
    noOfCards: 9,
    noToChoose: 3,
    type: "strongest attitudes"});

  $('#cards_sort_4').cardSort({
    noOfCards: 6,
    noToChoose: 1,
    type: "weakest attitudes"});

});
