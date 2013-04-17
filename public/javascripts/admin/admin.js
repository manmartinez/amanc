var amanc = {
  root: null,
  csrf_params: {},
  init: function() {
    this.root = this;
    this.initCsrfParams();
    this.initTooltips();
    this.initLinks();
  },
  initCsrfParams: function() {
    var key = $('meta[name="csrf-param"]').attr('content');
    var value = $('meta[name="csrf-token"]').attr('content');
    this.csrf_params[key] = value;
  },
  initTooltips: function() {
    $('[data-tooltip]').tipsy({
      fade: true,
      gravity: 's',
      title: 'data-tooltip',
      opacity: 0.9
    });  
  },
  initLinks: function() {
    _self = this;
    $('a[data-method="delete"]').click(function(e){
      e.preventDefault();
      var current_url = window.location;
      $.ajax({
        type: 'delete',
        data: _self.csrf_params,
        url: $(this).attr('href') + '.json',
        success: function(data) {
          window.location = current_url;
        },
        error: function() {
          _self.error();
        }        
      });
    });
  },
  error: function() {
  
  }
}
