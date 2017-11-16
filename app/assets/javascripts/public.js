$(document).ready(function() {

  $('.disabled').click(function(e){ if($(this).hasClass('disabled')){ e.preventDefault(); }});
  $('.accordion').accordion();
  $('#alerts').alerts();

  $('#cards_sort_1').cardSort({
    noOfCards: 14,
    noToChoose: 5,
    type: 'cards_sort_1',
    type_text: "strongest skills"});

  $('#cards_sort_2').cardSort({
    noOfCards: 9,
    noToChoose: 2,
    type: 'cards_sort_2',
    type_text: "weakest skills"});

  $('#cards_sort_3').cardSort({
    noOfCards: 9,
    noToChoose: 3,
    type: 'cards_sort_3',
    type_text: "best attitudes"});

  $('#cards_sort_4').cardSort({
    noOfCards: 6,
    noToChoose: 1,
    type: 'cards_sort_4',
    type_text: "weak attitudes"});

});
