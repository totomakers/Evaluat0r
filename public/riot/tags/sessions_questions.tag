<sessions_questions>
    <div class="row">
        <div class="col-lg-12">
            <h2>Questions - <small>{ questions.length } question(s)</small></h2>
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-7">
            <div class="alert alert-warning">
                <strong>ATTENTION !</strong></br>Vous ne pouvez tirez au sort les questions que si la session n'en a pas ou que la date du jour est postérieur a la date de début.
            </div>
        </div>
        <div class="col-lg-5 text-right">
            <div id="questions-put-alert-box"></div>
            <form class="form-inline" onsubmit={putQuestions}>
                <label for="sessions_template">Votre modèle:</label>
                <select class="form-control" id="sessions-template" placeholder="" style="width: 50%"></select>
                <button type="submit" class="btn btn-danger" id="sessions-questions-button-rand"><i class="fa fa-random"></i> Tirer au sort</button>
            </form>
        </div>
    </div>
    <div class="row" class="animated" id="questions-data" hidden>
        <div class="col-lg-12">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <div class="panel panel-default animated fadeIn" id="questions-content" each={questions}>
                <div class="panel-heading" role="tab" id="{ 'question-heading-'+id }">
                  <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="{ '#question-collapse-'+id }" aria-expanded="true" aria-controls="{ 'question-collapse-'+id }">
                        { stripHTML(markdown.toHTML(wording)) }...
                    </a>
                  </h4>
                </div>
                <div id="{ 'question-collapse-'+id }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="{ 'question-heading-'+id }">
                  <div class="panel-body" id="{ 'question-content-'+id }">
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
                                                <input type="checkbox" class="styled" id="answer_add_good" checked={good} disabled>
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
        self.questions = [];
        
        self.stripHTML = function(html)
        {
            html = html.replace(/<\/?[^>]+(>|$)/g, "");
            html = html.replace(/(\r\n|\n|\r)/gm," ");
            html = he.decode(html);
            
            return html;
        }
        
        this.on('mount', function() {
            opts.session.getQuestions(opts.page.id);
            
            //select2
            $("#sessions-template").select2({
                  language: 'fr',
                  minimumInputLength: 2,
                  ajax: {
                    url: "api/templates/select2",
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                      return {
                        q: params.term, // search term
                      };
                    },
                    processResults: function (data, page) {
                      return { results: data.data };
                    },
                    
                    results: function (data) {
                        var newData = [];
                        $.each(data, function (index ,value) {
                            newData.push({
                                id: value.id,  //id part present in data
                                text: value.name,  //string to be displayed
                            });
                        });
                    },
                    
                    cache: true
                  },
                  escapeMarkup: function (markup) { return markup; },
                  minimumInputLength: 1,
                  templateResult: self.select2TemplateTemplate,
                  templateSelection: self.select2TemplateSelect
            });
        });
        
        
        putQuestions(e){
            self.enableForm(false);
            opts.session.putQuestions(opts.page.id, $('#sessions-template').val());
        }
        
        //-----------
        //UTILS -----
        //-----------
        
        self.enableForm = function(enable)
        {
            var button = $('#sessions-questions-button-rand');
            var select = $('#sessions-template');
            
            if(enable == true)
            {
                select.removeAttr('disabled');
                button.removeAttr('disabled');
            }
            else
            {
                select.attr('disabled', 'disabled');
                button.attr('disabled', 'disabled');
            }
        }
        
        self.select2TemplateTemplate = function(result) 
        {
            if (result.loading) return "Chargement...";
        
            var markup = '<div>'+result.name+'</div>'
            return markup;
        }
          
        self.select2TemplateSelect = function(selection) {
            return selection.name;
        }
        
        //--------------
        //EVENTS -------
        //--------------
        
        opts.session.on('session_questions', function(json)
        {
            self.questions = json.data;
            self.update();
            
            $('#questions-data').show();
            refreshTooltip();
        });
        
        opts.session.on('session_put_questions', function(json)
        {
            if(json.error == true)
            {
                alert.show('#questions-put-alert-box', 'danger', json.message);
            }
            else
            {
                alert.show('#questions-put-alert-box', 'success', json.message);
                self.questions = json.data;
                self.update();
            }
           
            self.enableForm(true);
            refreshTooltip();
        });

    </script>
</sessions_questions>
