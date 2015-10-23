<questions hidden>
    <div class="row">
        <div class="col-lg-12">
            <h2>{ questionsData.length } questions</h2>
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <div class="panel panel-default animated fadeIn" id="questions_content" each={questionsData} >
                <div class="panel-heading" role="tab" id="{ 'question_heading_'+id }">
                  <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="{ '#question_collapse_'+id }" aria-expanded="true" aria-controls="{ 'question_collapse_'+id }">
                        { stripHTML(markdown.toHTML(wording)) }...
                    </a>
                     <span class="pull-right"><a href="" onclick={question_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"></i></a></span>
                  </h4>
                </div>
                <div id="{ 'question_collapse_'+id }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="{ 'question_heading_'+id }">
                  <div class="panel-body" id="{ 'question_content_'+id }">
                        <raw content="{markdown.toHTML(wording)}"></raw>
                        <hr>
                        <div class="table">
                            <table class="table table-hover table-striped">
                                <thead>
                                    <th>Réponse</th>
                                    <th>Bonne réponse</th>
                                </thead>
                                <tbody>
                                    <tr each={this.answers}>
                                        <td>{wording}</td>
                                        <td>  
                                            <span class="checkbox checkbox-success checkbox-circle">
                                                <input type="checkbox" class="styled" id="answer_add_good" checked={good}>
                                                <label for="answer_add_good"></label>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                  </div>
                </div>
              </div>
            </div>
        </div>
    </div>

    <script>
        var self = this;
        self.questionsData = [];
        
        this.on('mount', function(){
            opts.themes.getQuestions(opts.page.id);
        });
        
        self.stripHTML = function(html)
        {
            html = html.replace(/<\/?[^>]+(>|$)/g, "");
            html = html.replace(/(\r\n|\n|\r)/gm," ");
            html = he.decode(html);
            
            return html;
        }
        
        //-------
        //SIGNAL
        //-------
        question_delete(e){
            opts.questions.delete(e.item.id);
        }
        
        //--------
        //EVENT --
        //--------
        
        opts.themes.on('theme_getQuestions', function(json) {
            self.questionsData = json.data;
            self.update();
            refreshTooltip();
        });
        
        opts.questions.on('questions_refresh', function()
        {
            opts.themes.getQuestions(opts.page.id);
        });
        
        opts.questions.on('question_delete', function(json)
        {
            var index = self.questionsData.map(byId).indexOf(json.data.id);
            self.questionsData.splice(index,1);
            
            self.update();
            refreshTooltip();
        });
        
    </script>
</questions>