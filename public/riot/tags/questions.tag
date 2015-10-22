<questions>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Themes C#<small> - Description</small></h1>
                <hr>
            </div>
        </div>
        <form id="questions_form">
            <div class="row">
                <div class="col-lg-8">
                    <div class="form-group">
                        <label for="question">Question</label>
                        <textarea class="form-control textarea-fixed" id="question" name="question" rows="10"></textarea>
                    </div>
                    <div class="table">
                    <table id="question_data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Réponse</th>
                                <th>Bonne réponse</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="text" class="form-control" id="answer_add_wording" oninput={answer_input} placeholder="Libellé"></input></td>
                                <td>
                                    <span class="checkbox checkbox-success">
                                        <input type="checkbox" class="styled" id="answer_add_good">
                                        <label for="answer_add_good"></label>
                                    </span>
                                </td>
                                <td class="text-right"><button id="answer_add_submit" class="btn btn-success btn-lg" onclick={answer_add}><i id="answer_submit_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={answers}>
                                <td>{wording}</td>
                                <td>
                                    <span class="checkbox checkbox-success checkbox-circle">
                                        <input type="checkbox" class="styled" id="answer_add_good" checked={good} disabled>
                                        <label for="answer_add_good"></label>
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
                        <button type="reset" class="btn btn-danger" onclick={answers_clear}>Effacer</button>
                        <button type="submit" class="btn btn-success">Ajouter</button>
                    </div>
                </div>
            </div>
        </form>
         <div id="test">
         </div>
    </div>
   
    <script>
        var self = this;
        self.answers = [];
        
        loader.show();
        loader.hide();

        this.on('mount',function() 
        {
            refreshTooltip();
            
            $("#question").markdown({
                fullscreen:{enable:false},
                iconlibrary:'fa',
                resize:'vertical',
                hiddenButtons:'Image',
            })
        });
        
        //----------------
        //UTILS ----------
        //----------------
        
        self.checkAnswerInput = function(){
            var input = $('#answer_add_wording');
            
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
        
        
        //----------------
        //EVENTS ---------
        //----------------
        
        answers_clear(e) {
            $('#questions_form')[0].reset();
            self.answers = [];
            self.update();
        };
        
           
        answer_add(e){
            if(self.checkAnswerInput())
            {
                var wording = $('#answer_add_wording');
                var good = $('#answer_add_good');
                
                var newAnswer = new Answer();
                newAnswer.id = self.answers.length;
                newAnswer.wording = wording.val();
                newAnswer.good = good.is(":checked");
                self.answers.push(newAnswer);

                wording.val("");
                good.attr("checked", false);
                self.update();
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
</questions>