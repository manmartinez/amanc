(function(){
  $(function(){
    amanc.topics = $.extend(section_form, {
      formOnSuccess: function(data) {
        window.location = data.url;
      }
    });
    amanc.topics.init();    
  });
})(jQuery);
