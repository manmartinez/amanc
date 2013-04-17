(function(){
  $(function(){
    amanc.topics = {
      root: null,
      parent: amanc,
      init: function() {
        this.root = this.parent.root;
        this.initLevelsBtn();
      },
      initLevelsBtn: function() {
        var _self = this;
        $('a#create_level').click(function(e){
          e.preventDefault();
          $.ajax({
            type: 'post',
            url: $(this).attr('href'),
            success: function(data) {
              window.location = data.url;
            },
            error: function() {
              _self.root.error();
            },
            data: _self.root.csrf_params
          });
        });
      }
    
    };
    amanc.topics.init();    
  });
})(jQuery);
