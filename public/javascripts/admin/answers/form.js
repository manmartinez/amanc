(function(){
  $(function(){
    amanc.answers = $.extend(section_form, {
      formOnSuccess: function(data) {
        window.location = data.url;
      }
    });
    amanc.answers.init();    
  });
})(jQuery);
