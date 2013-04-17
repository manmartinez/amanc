(function(){
  $(function(){
    amanc.questions = $.extend(section_form, {
      formOnSuccess: function(data) {
        window.location = data.url;
      }
    });
    amanc.questions.init();    
  });
})(jQuery);
