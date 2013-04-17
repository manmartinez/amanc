(function(){
	var _nil = $();
	$.fmx_form = function(options){
		var _self = {
			uploaders: [],
			container: _nil,
			submit_btn: null,
			extra_params: {},
			reset_btn: null,
			fields_with_errors: null,
			use_field_namespace: true,			
			ajax_opts: {},
			init: function(){	
				_self.initSubmitBtn();
				this.initResetBtn();
				_self.container.addClass('fmx_form');
				_self.container.submit(_self.onSubmit);
			},
			initResetBtn: function(){
				this.reset_btn = $('<input />', {
					type: 'reset'
				}).addClass('fmx_form_reset_btn');
				this.reset_btn.insertAfter(this.submit_btn);
			},
			reset: function(){
				this.reset_btn.click();
			},
			initSubmitBtn: function(){
				_self.submit_btn = _self.container.find('input[type="submit"]');
			},
			_loading: function(){
				_self.submit_btn.addClass('disabled');
				_self.loading();
			},
			loading: function(){},
			_loaded: function(){
				_self.submit_btn.removeClass('disabled');
				_self.loaded();
			},
			loaded: function(){},
			onError: function(){
				$.fmx_notification({
					type: 'error',
					msg: 'There was an error. Please try again later'
				});
			},
			onSubmit: function(e){
				e.preventDefault();
				if(_self.uploaders.length > 0){
					var can_submit = true;
					for(var i=0; i<_self.uploaders.length && can_submit; ++i){
						if(_self.uploaders[i].state == $.fmx_uploader_states.uploading){
							can_submit = false;
						}
					}
					if(can_submit){
						_self.doSubmit();
					}
					else{
						$.fmx_notification({
							icon_src: 'error',
							msg: 'Hay archivos en espera de upload. Por favor espera a que se acaben de subir.'
						});
					}
				}
				else{
					_self.doSubmit();
				}
			},
			doSubmit: function(){
				if(!_self.submit_btn.is('.disabled')){
					_self.removeErrors();
					_self._loading();
					var extra_params = [];
					$.each(_self.extra_params, function(key, value){
					    extra_params.push({
					        'name': key,
					        'value': value
					    });
					});
					var the_data =$.merge(_self.container.serializeArray(),extra_params);					
					$.ajax($.extend({
						type: 'post',
						url: _self.container.attr('action') + '.json',
						data: the_data,
						success: _self.onResponse,
						error: _self.onError,
						complete: _self._loaded
					}, _self.ajax_opts));
				}
			},
			onResponse: function(data){				
				var length = 0;
				if(data.errors) {
				  $.each(data.errors, function(field, errors){
					  ++length;
					  _self.renderError(field,errors);
				  });
				}				
				if(length == 0){
					_self.onSuccess(data);
				}				
			},
			removeErrors: function() {	
				if(_self.fields_with_errors) {
					$.each(_self.fields_with_errors, function(key, field){
						field.parent().find('.field_errors').html('');
						field.removeClass('field_with_errors');
					});
				}							
				_self.fields_with_errors = [];								
			},
			renderError: function(field, errors){
				var patt =/\[[\w\d_]+\]/
				var inputs = _self.container.find('.field :input');
				var input = null;
				if(_self.use_field_namespace){
					for(var i = 0; i < inputs.length; ++i) {
						var s = patt.exec($(inputs[i]).attr('name'));
						if(s){
							s = s[0];
							s = s.substr(1,s.length-2);
							if(s == field) {
								input = $(inputs[i]).addClass('field_with_errors');		
								break;
							}
						}
					}				
				}
				else{
					var tmp = _self.container.find(':input[name="' + field + '"]').addClass('field_with_errors');
					input = tmp.length == 0 ? null : tmp;
				}
				if(input != null){
					_self.fields_with_errors.push(input);
					var div = input.parent().find('.field_errors');
					if(div.length == 0) {
						s = '<div class="field_errors"></div>';
						div = $(s);
						div.appendTo(input.parent());	
					}				
					s = '';
					$.each(errors, function(key,error){
						s += error + ', '; 
					});
					s = s.substring(0, s.length-2);
					div.html(s).hide().fadeIn(500);	
				}
			},
			onSuccess: function(){
				alert("It worked!");
			}
		};
		$.extend(_self, options)
		_self.init();
		return _self;
	};
})(jQuery);
