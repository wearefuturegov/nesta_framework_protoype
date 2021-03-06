$.fn.accordion = function() {
  if (this.length === 0) { return false; }

  $(this).click(function() {
    var $this = $(this);
    if ($this.parent().hasClass('open')) {
      if($this.parent().hasClass('parent_accord')) {
        $('.accordion').removeClass('open');
        $('.accord_arrow').removeClass('rotate');
      }
      $this.parent().removeClass('open');
      $this.find('.accord_arrow').removeClass('rotate');
      $this.next().slideUp(500);

    } else {
      $this.parent().parent().find('.accord_content').removeClass('open');
      $this.parent().parent().find('.accord_content').slideUp(500);
      $this.parent().parent().find('.accord_arrow').removeClass('rotate');
      $this.parent().toggleClass('open');
      $this.find('.accord_arrow').addClass('rotate');
      $this.next().slideToggle(500);
    }
  });
};


