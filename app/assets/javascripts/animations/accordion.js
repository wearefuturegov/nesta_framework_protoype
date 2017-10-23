$.fn.accordion = function() {
  if (this.length === 0) { return false; }

  $(this).click(function() {
    if($(this).hasClass('open')) {
      closeAccord($(this));
    } else {
      checkOtherAccords($(this));
      openAccord($(this));
    }
  });

  function openAccord(currentClick) {
    currentClick.addClass('open');
    currentClick.find('.accord-content').slideDown(500);
  }

  function closeAccord(currentClick) {
    currentClick.removeClass('open');
    currentClick.find('.accord-content').slideUp(500);
  }

  function checkOtherAccords(currentClick) {
    var otherOpen = currentClick.closest('.accord-cont').find('.open');
    if (otherOpen.length ===0) { return false; }

    closeAccord(otherOpen);
  }

};
