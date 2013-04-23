(function(){
  $(function(){
    $.extend(amanc.game, {
      question_namespace: 'question',
      question_container: null,
      banner_container: null,
      score_container: null,
      level_container: null,
      correct_container: null,
      incorrect_container: null,
      level: 1,
      init: function() {
        this.initCorrectContainer();
        this.initIncorrectContainer();
        this.initBannerContainer();
        this.initScoreContainer();
        this.initQuestionContainer();
        this.initLevelContainer();
        this.initAnswers();                
      },
      initIncorrectContainer: function() {
        this.incorrect_container = $('#incorrect_animation_container');
      },
      initCorrectContainer: function() {
        this.correct_container = $('#correct_animation_container');
      },
      initBannerContainer: function() {
        this.banner_container = $('#banner_wrapper');
      },
      initLevelContainer: function() {
        this.level_container = $('#current_level');
        this.level_animation_container = $('#level_animation_container');
      },
      initQuestionContainer: function() {
        this.question_container = $('#question_container');
      },
      initScoreContainer: function() {
        this.score_container = $('#score_container');
      },
      initAnswers: function() {
        var _self = this;
        $('a.answer').click(function(e){
          e.preventDefault();
          _self.answerOnClick($(this));
        });
      },
      answerOnClick: function(answer) {
        var _self = this;
        var data = $.extend(amanc.csrf_params,{answer_id: answer.attr('data-id') });
        $.ajax({
          type: 'post',
          url: answer.attr('href') + '.json',
          data: data,
          complete: function() {
          
          },
          error: function() {
            
          },
          success: function(data) {
            _self.onQuestionAnswered(data);
          }
        });
      },
      onQuestionAnswered: function(data) {
        this.displayFeedback(data);
        if(data.game.game['closed?']) {
          this.finishHim();
        }
        else {
          this.changeQuestion(data.next_question);          
        }
        this.changeBanner(data.banner.banner);
        this.updateScore(data.game.game);
        this.updateLevel(data.game.game);
      },
      displayFeedback: function(data) {        
        var container = null;
        if(data.answer_was_correct) {
          if(data.game.game.level.level_number == this.level) {
            container = this.correct_container;
            this.correct_container.addClass('animate');
          }          
        }
        else {
          container = this.incorrect_container;
          this.incorrect_container.addClass('animate');
        }
        setTimeout(function(){ if(container) { container.removeClass('animate') } },1000);
      },
      changeBanner: function(banner) {
        this.banner_container.html('');
        var banner_link = $('<a></a>')
                              .attr('href', this.view_banner_url.replace(/%id%/g, banner.id))
                              .attr('target', '_blank');
        $('<img />').attr('src', amanc.asset_host + banner.image_url).appendTo(banner_link);
        banner_link.appendTo(this.banner_container);
      },
      updateScore: function(game) {
        this.score_container.text(game.score);
      },
      updateLevel: function(game) {
        if(game.level.level_number != this.level) {
          this.level = game.level.level_number;
          this.level_animation_container.find('span.level_number').text(this.level);
          this.level_animation_container.removeClass('animate');
          this.level_animation_container.addClass('animate');
          this.level_container.text(game.level.level_number);
        }        
      },
      finishHim: function() {
        $('#question_container').hide();
        $('#game_ended').fadeIn();
      },
      changeQuestion: function(hash) {
        var question = {
          parent: this,
          markup: null,
          data: hash[this.question_namespace],
          init: function() {
            this.initMarkup();
            this.initAnswers();
            this.switchThatWitch();
          },
          initMarkup: function() {
            this.markup = this.tpl().replace(/%{text}/g, this.data.text);
            this.markup = $(this.markup);
          },
          initAnswers: function() {
            var _self = this;
            $.each(this.data.answers, function(index, answer) {
              _self.addAnswer(answer);
            });
          },
          addAnswer: function(data) {
            var answer = {
              data: data,
              markup: null,
              init: function() {
                this.initMarkup();
              },
              initMarkup: function() {  
                this.markup = this.tpl()
                                  .replace(/%{id}/g, this.data.id)
                                  .replace(/%{text}/g, this.data.text)
                                  .replace(/%{url}/g, amanc.game.next_question_url);
                this.markup = $(this.markup).click(function(e){
                  e.preventDefault();
                  question.parent.answerOnClick($(this));
                });
              },
              tpl: function() {
                var s = '<a href="%{url}" class="answer" data-id="%{id}">%{text}</a>';
                return s;
              }
            };
            answer.init();
            answer.markup.appendTo(this.markup);
          },          
          tpl: function() {
            var s = '<div class="question">';
            s += '<h2 class="white">%{text}</h2>';
            s += '</div>';        
            return s;
          },
          switchThatWitch: function() {
            this.parent.question_container.html('');
            this.markup.appendTo(this.parent.question_container).hide().fadeIn();
          }         
        };
        question.init();        
      }
    });
    amanc.game.init();
  });
})(jQuery);
