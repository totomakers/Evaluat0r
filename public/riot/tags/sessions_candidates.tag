<sessions_candidates>
    <div id="subloader" class="text-center" hidden>
        <i class="fa fa-spinner fa-spin fa-3x"/>
    </div>
    <div id="templates-themes-content" class="animated fadeIn" >
        <div class="row">
            <div class="col-lg-12">
                <h2>Candidats <small>({candidates.length})</h2>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="row">
                <div class="col-lg-12" id="sessions-candidates-alert-box">
                </div>
            </div>
            <div class="col-lg-12">
                <div class="table">
                    <table class="table table-striped table-hover">
                        <thead>
                            <th>Candidats</th>
                            <th>Inscription le</th>
                            <th class="text-center">Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td><select class="form-control" id="sessions-candidates-name" placeholder=""></select></td>
                                <td></td>
                                <td class="text-center"><button id="sessions-candidates-add-button" class="btn btn-success btn-lg"><i id="model_theme_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr each={candidates}>
                                <td><a href="#">{firstname} {lastname}</a></td>
                                <td>{ dateTimeFormatFr(pivot.created_at) }</td>
                                <td class="text-center"><a href="" onclick={sessions_remove_candidates}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script>
        var self = this;
        self.candidates = [];
        
        this.on('mount', function() {
            //select2
            $("#sessions-candidates-name").select2({
                  language: 'fr',
                  minimumInputLength: 2,
                  ajax: {
                    url: "api/accounts/select2/candidates",
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
                                text: value.firstname + ' ' + value.lastname,  //string to be displayed
                            });
                        });
                    },
                    
                    cache: true
                  },
                  escapeMarkup: function (markup) { return markup; },
                  minimumInputLength: 1,
                  templateResult: self.select2CandidateTemplate,
                  templateSelection: self.select2CandidateSelect,
            });
            
            opts.session.getCandidates(opts.page.id);
        });

        //----------
        //SIGNALS --
        //----------
        
        sessions_remove_candidates(e){
            opts.session.removeCandidate(opts.page.id, e.item.id);
        }
        
        //-----------
        //UTILS -----
        //-----------
        
        self.select2CandidateTemplate = function(result) 
        {
            if (result.loading) return "Chargement...";
        
            var markup = '<div>'+result.firstname+' ' + result.lastname + '</div>';
            return markup;
        }
          
        self.select2CandidateSelect = function(selection) {
            return selection.firstname + ' ' + selection.lastname;
        }
        
        //-------------
        //EVENTS ------
        //--------------
        
        opts.session.on('session_candidates', function(json)
        {
            self.candidates = json.data;
            self.update();
            refreshTooltip();
        });
        
        opts.session.on('session_remove_candidate', function(json)
        {
            if(json.error == true)
                 alert.show('#sessions-candidates-alert-box', 'danger', json.message);
            else
            {
                alert.show('#sessions-candidates-alert-box', 'success', json.message);
                opts.session.getCandidates(opts.page.id);
            }
        });
        
    </script>
</sessions_candidates>