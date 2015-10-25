<themes_questions_add> 
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12 animated fadeIn" id="theme-title" hidden>
                <h1> <a data-toggle="tooltip" data-placement="bottom" title="Retour" href="javascript:history.back()"><i class="fa fa-chevron-left"></i></a> Thème {theme.name} <small> - {theme.description} </small></h1>
                <hr>
            </div>
        </div>
        <div class="row animated fadeIn">
            <div class="col-lg-8" id="alert-box">
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <h2><small>Nouvelle question :</small></h2>
            </div>
        </div>
        <form id="question-form">
            <div class="row">
                <div class="col-lg-8">
                    <div class="form-group">
                        <label for="question"></label>
                        <textarea class="form-control textarea-fixed" id="question" name="question" rows="10"></textarea>
                    </div>
                    <div class="table-responsive">
                        <table id="question-data" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Réponse</th>
                                    <th>Bonne réponse</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" class="form-control" id="answer-add-wording" oninput={answer_input} placeholder="Libellé"></input></td>
                                    <td>
                                        <span class="checkbox checkbox-success">
                                            <input type="checkbox" class="styled" id="answer-add-good">
                                            <label for="answer-add-good"></label>
                                        </span>
                                    </td>
                                    <td class="text-right"><button id="answer-button-add" class="btn btn-success btn-lg" onclick={answer_add}><i id="answer-button-add-ico" class="fa fa-plus fa-lg"></i></button></td>
                                </tr>
                                <tr each={answers}>
                                    <td>{wording}</td>
                                    <td>
                                        <span class="checkbox checkbox-success checkbox-circle">
                                            <input type="checkbox" class="styled" id="answer-add-good" checked={good} disabled>
                                            <label for="answer-add-good"></label>
                                        </span>
                                    </td>
                                    <td class="text-right">
                                        <a href="" onclick={answer_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-right">
                        <button type="reset" class="btn btn-danger" onclick={answer_deleteAll}>Effacer</button>
                        <button type="submit" class="btn btn-success" onclick={question_add} id="question-button-add">Ajouter la question</button>
                    </div>
                </div>
            </div>
        </form>
    </div> 
    
     <script>
        var self = this;
        self.answers = [];
        self.theme = [];
        
        loader.show();
        
        this.on('mount',function() 
        {
            opts.theme.get(opts.page.id);
            refreshTooltip();
            
            $("#question").markdown({
                fullscreen:{enable:false},
                iconlibrary:'fa',
                resize:'vertical',
                hiddenButtons:'Image',
            })
            
            loader.hide();
        });
        
        opts.theme.on('theme_get', function(json) 
        {
            self.theme = json.data;
            self.update();
            
            $('#theme-title').show();
        });
        
        opts.question.on('question_add', function(json)
        {
            if(json.error == false)
            {
                var question = $('#question');
                var wording = $('#answer-add-wording');
                var good = $('#answer-add-good');
                
                wording.val("");
                question.val("");
                good.attr("checked", false);
                
                self.answers = [];
                
                alert.show('#alert-box', 'success', json.message);
                opts.question.refresh();
            }
            else
                alert.show('#alert-box', 'danger', json.message);
            
            self.enableForm(true);
            self.update();
        });
        
        //----------------
        //UTILS ----------
        //----------------
        
        self.checkAnswerInput = function(){
            var input = $('#answer-add-wording');
            
            if(!input.val())
            {
                input.parent().addClass('has-error');
                return false;
            }
            else
            {
               input.parent().removeClass('has-error');
               return true;
            }
        };
        
        self.enableForm = function(enable)
        {
            //button
            var button = $('#question-button-add');
            var question = $('#question');
             
            if(enable == true)
            {
                button.removeAttr('disabled');
                question.removeAttr('disabled');
            }
            else
            {
                button.attr('disabled', 'disabled');
                question.attr('disabled', 'disabled');
            }
        }
        
        
        //----------------
        //SIGNAL ---------
        //----------------
        
        question_add(e) {
            var questionParams = { wording : "", answers : self.answers, theme_id : self.theme.id };
            questionParams.wording = this.question.value;
            self.enableForm(false);
            
            opts.question.add(questionParams);
        };

        answer_deleteAll(e) {
            $('#question-form')[0].reset();
            self.answers = [];
            self.update();
        };
        
           
        answer_add(e){
            if(self.checkAnswerInput())
            {
                var wording = $('#answer-add-wording');
                var good = $('#answer-add-good');
                
                var newAnswer = new Answer();
                newAnswer.id = self.answers.length;
                newAnswer.wording = wording.val();
                newAnswer.good = good.is(":checked");
                self.answers.push(newAnswer);

                wording.val("");
                good.attr("checked", false);
                refreshTooltip();
            }
        }
        
        answer_input(e){
            self.checkAnswerInput();
        }
        
        answer_delete(e){
            var index = self.answers.map(byId).indexOf(e.item.id);
            self.answers.splice(index, 1);
            
            self.update();
            refreshTooltip();
        }
        
        
    </script>
</themes_questions_add>