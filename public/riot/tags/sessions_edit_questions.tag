<sessions_edit_questions>
    <div class="row">
        <div class="col-lg-12">
            <h2>Questions</h2>
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
              <div class="panel panel-default animated fadeIn" id="questions-content" each={questionsData} >
                <div class="panel-heading" role="tab" id="{ 'question-heading-'+id }">
                  <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="{ '#question-collapse-'+id }" aria-expanded="true" aria-controls="{ 'question-collapse-'+id }">
                        { stripHTML(markdown.toHTML(wording)) }...
                    </a>
                     <span class="pull-right"><a href="" onclick={question_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"></i></a></span>
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
</sessions_edit_questions>