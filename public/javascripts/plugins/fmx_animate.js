(function(){
  $.fmx_animate = function(opts) {
    var _self = {
      step: 0,
      init: function() {
        this.fadeElementsIn();
      },
      fadeElementsIn: function() {
        console.log(this.step);
        var elements = $('[data-transition="fade_in"][data-step="' + this.step + '"]');
        if(elements.length > 0) {
          elements.fadeIn(500);
          setTimeout(function(){            
            ++_self.step;
            _self.init();          
          }, 500);
        }
      }
    };
    $.extend(_self, opts);
    _self.init();
    return _self;
  }
})(jQuery);
