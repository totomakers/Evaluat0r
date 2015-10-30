<evaluations_exam>
    <div class="row">
        <div class="col-lg-2">
        </div>
        <div class="col-lg-8 text-center">
            <h3>{ session.duration == '00:00:00' ? 'Pas de limite' : timer }</h3>
        </div>
        <div class="col-lg-2 text-right">
            <a href="#evaluations" type="button" class="btn btn-danger"><i class="fa fa-close fa-lg v-align"></i> Quitter</a>
        </div> 
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="row text-center">
                <div class="col-lg-2">
                    <a class="pull-left v-align" href="#" onclick={questionPrev}><i class="fa fa-chevron-left"></i> Question précédentes</a>
                </div> 
                <div class="col-lg-8">
                    <ol class="carousel-linked-nav pagination">
                        <li each={question, i in session.questions} class="btn btn-{getQuestionColor(question)}" id="question-button-{i}" onclick={question_show}>{i+1}</li>
                    </ol>
                </div>
                <div class="col-lg-2">
                    <a class="pull-right" href="#" onclick={questionNext}>Question suivantes <i class="fa fa-chevron-right"></i></a>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-offset-3 col-lg-6"  id="exam-alert-box">
                </div>
            </div>
        </div>
        <div class="row">
            <form role="form" onsubmit={question_validate}>
            <div each={question, i in session.questions} class="col-lg-offset-2 col-lg-8 item animated fadeIn" id="question-{i}" hidden>
                <div>
                    <h3 class="text-center">{session.name} - <small class="lead">Question {i+1}</small></h3>
                    <hr>
                </div>
                <div class="well well-sm">
                    <raw content={markdown.toHTML(question.wording)}></raw>
                </div>
                <hr>
                <div>
                    <h4>Réponse(s) <small>- {question.good_answer_count} possibilité(s)</small></h4>
                        <div each={answer, i in question.answers}>
                            <div class="checkbox checkbox-success"> 
                                <input type="checkbox" id="answer-{answer.id}" value={answer.id} name="checkbox_answer[]"/>
                                <label for="answer-{answer.id}">
                                    {answer.wording}
                                </label>
                            </div>
                        </div>
                        <div class="text-center">
                            <button class="btn btn-success" type="submit" id="btn-evaluation-save">Sauvegarder</button>
                            <button class="btn btn-warning" onclick={questionMark}>Marquer</button>
                            <button class="btn btn-danger">Terminer le test</button>
                        </div>
                    
                </div>
            </div>
            </form>
        </div>  
    </div>
    <script>
        var self = this;
        self.session = [];
        self.currentQuestionIndex = -1;
        self.timer = '00:00:00';
        self.jsTimer;
        
        loader.hide();
        
        this.on('mount', function(){
            opts.evaluation.getQuestions(opts.page.id);
            
           $('.carousel').carousel({
                wrap: false,
                interval:false,
            })
        });
        
        //-------------
        //UTILS -------
        //-------------
        
        self.timerTick = function()
        {
            opts.evaluation.getTimer(opts.page.id);
        }
        
        self.showQuestion = function(id)
        {
            var question = $('#question-'+id);
            var questionButton = $('#question-button-'+id);
            
            question.show();
            questionButton.addClass('active');
            self.currentQuestionIndex = id;
        }
        
        self.hideQuestion = function(id)
        {
            var question = $('#question-'+id);
            var questionButton = $('#question-button-'+id);
            
            question.hide();
            questionButton.removeClass('active');
        }
        
        self.getQuestionColor = function(question)
        {
            return 'primary';
        }
        
        questionPrev(e){
            var index = self.currentQuestionIndex;
            if((self.currentQuestionIndex-1) >= 0)
            {
                index -= 1;
                self.hideQuestion(self.currentQuestionIndex);
                self.showQuestion(index);
            }
        }
        
        questionNext(e){
            if(!self.session || !self.session.questions) return;
            
            var index = self.currentQuestionIndex;
            if((self.currentQuestionIndex+1) < self.session.questions.length)
            {
                index += 1;
                self.hideQuestion(self.currentQuestionIndex);
                self.showQuestion(index);
            }
        }
        
        questionMark(e){
            var question_id = self.session.questions[self.currentQuestionIndex].id;
            evaluation.mark(opts.page.id, question_id);
        }
        
        //-------------
        //SIGNALS -----
        //-------------
        
        question_show(e){
            self.hideQuestion(self.currentQuestionIndex);
            self.showQuestion(e.item.i);
        };
        
        question_validate(e){
            var checkbox = $("input[name='checkbox_answer[]']:checked").map(function(){
                return $(this).val();
            }).get();
            
            $('#btn-evaluation-save').attr('disabled', 'disabled');
            opts.evaluation.postAnswers(opts.page.id, checkbox);
        });
        
        //-------------
        //EVENTS ------
        //-------------
        
        opts.evaluation.on('evaluation_questions', function(json)
        {
            self.session = json.data;
            self.update();
            
            if(json.error == true)
                alert.show('#exam-alert-box', 'danger', json.message);
            
            if(json.error == false)
            {
                if(self.session.duration != '00:00:00')
                    self.jsTimer = setInterval(self.timerTick, 1000);
                
                if(json.data.questions.length > 0)
                    opts.evaluation.getAnswers(opts.page.id);
            }
        });
        
        opts.evaluation.on('evaluation_get_answers', function(json)
        {
            var answers = json.data;
            
            for(var i = 0; i < answers.length; i++)
                $('#answer-'+answers[i].answer_id).attr('checked', true);
            
            if(json.error == false)
                self.showQuestion(0);
        });
        
        opts.evaluation.on('evaluation_get_timer', function(json)
        {
            if(json.error == false)
            {
                if(json.data == '00:00:02')
                    $('#btn-evaluation-save').click();
                    
                 self.timer = json.data;
            }
            else
            {
               self.timer = '00:00:00';
               clearInterval(self.jsTimer);
               alert.show('#exam-alert-box', 'danger', json.message);
            }
            
            self.update();
        });
        
        opts.evaluation.on('evaluation_post_answers', function(json)
        {
            $('#btn-evaluation-save').removeAttr('disabled');
        
            $.notify({
                message: json.message,
                icon: 'fa fa-smile-o',                
            },{
                // settings
                type: 'success',
                
                placement: {
                    from: "bottom",
                    align: "right"
                },
                
                delay:1000,
                timer:500,
            });
        });
    </script>    
        
    </script>
</evaluations_exam>