$.fn.followTo = function ( pos, top ) {
  var $this = this,
      $window = $(window);

  $window.scroll(function(e){
    if($(window).width() > 960)  {
      if ($window.scrollTop() > pos) {
        $this.css({
          position: 'absolute',
          top: pos
        });
      } else {
        $this.css({
          position: 'fixed',
          top: top
        });
      }
    }
  });
};
