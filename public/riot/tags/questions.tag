<questions hidden>
    <div class="row">
        <div class="col-lg-12">
            <h2>Questions <small>{ questionsData.length }</small></h2>
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <div class="panel panel-default" each={questionsData}>
                <div class="panel-heading" role="tab" id={ 'question_heading_'+id }>
                  <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href={ '#question_collapse_'+id } aria-expanded="true" aria-controls={ 'question_collapse_'+id }>
                      { stripHTML(markdown.toHTML(wording)) }...
                    </a>
                  </h4>
                </div>
                <div id={ 'question_collapse_'+id } class="panel-collapse collapse in" role="tabpanel" aria-labelledby={ 'question_heading_'+id }>
                  <div class="panel-body" id={ 'question_content_'+id }>
                        <raw content="{markdown.toHTML(wording)}"></raw>
                        <hr>
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
            return html;
        }

        //--------
        //EVENT --
        //--------
        
        opts.themes.on('theme_getQuestions', function(json) {
            self.questionsData = json.data;
            self.update();
        });
        
    </script>
</questions>