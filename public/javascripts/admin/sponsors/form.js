(function(){
  $(function(){
    amanc.sponsors = $.extend(section_form, {
      formOnSuccess: function(data) {
        window.location = data.url;
      }
    });
    amanc.sponsors.init();    
  });
})(jQuery);
