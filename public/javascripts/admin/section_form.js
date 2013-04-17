var section_form = {
  form: null,
  parent: amanc,
  root: null,
  init: function() {
    this.root = this.parent.root;
    this.initForm();
  },
  initForm: function() {
    var _self = this;
    this.form = $.fmx_form({
      container: $('#section_form'),
      onError: function() {
        _self.root.error();
      },
      onSuccess: function(data) {
        _self.formOnSuccess(data);
      }
    });
  },
  formOnSuccess: function(data) {
    window.location = gon.success_url
  }
}
