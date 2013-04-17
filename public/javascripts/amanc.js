var amanc = {
  csrf_params: {},
  init: function() {
    this.initCsrfParams();
    this.initAnimations();
  },
  initCsrfParams: function() {
    var key = $('meta[name="csrf-param"]').attr('content');
    var value = $('meta[name="csrf-token"]').attr('content');
    this.csrf_params[key] = value;
  },
  initAnimations: function() {
    $.fmx_animate();
  }
};
