<evaluations>
    <div class="row">
        <div class="col-lg-12">
            <h2>Nouvelles <small> - { evaluations.available.length } évaluations</small></h2>
            <hr>
            <div class="col-lg-12 text-center" id="evaluations-available-loader">
                <i class="fa fa-3x fa-gear fa-spin"></i>
            </div>
            <div class="row animated fadeIn" id="evaluations-available-content" hidden>
               <div class="col-lg-12">
                <div class="table">
                    <table id="evaluations-available-data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom session</th>
                                <th>Date début</th>
                                <th>Date fin</th>
                                <th>Durée</th>
                                <th class="text-right">Nb. questions</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr each={ evaluations.available }>
                                <td class="v-align">{name}</td>
                                <td class="v-align">{dateFormatFr(start_date)}</td>
                                <td class="v-align">{dateFormatFr(end_date)}</td>
                                <td class="v-align">{(duration == '00:00:00') ? 'Illimité' : duration }</td>
                                <td class="text-right v-align">{question_count}</td>
                                <td class="text-right">
                                    <a href="#evaluations/details/{id}"><button id="template-add-button" class="btn btn-danger"><i id="template-add-button-ico" class="fa fa-inbox"></i> Commencer</button></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-lg-12">
            <h2>En cours <small> - { evaluations.in_progress.length } évaluations</small></h2>
            <hr>
            <div class="col-lg-12 text-center" id="evaluations-in-progress-loader">
                <i class="fa fa-3x fa-gear fa-spin"></i>
            </div>
            <div class="row animated fadeIn" id="evaluations-in-progress-content" hidden>
               <div class="col-lg-12">
                <div class="table">
                    <table id="evaluations-in-progress-data" class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Nom session</th>
                                <th>Date début</th>
                                <th>Date fin</th>
                                <th>Durée</th>
                                <th class="text-right">Question répondues</th>
                                <th class="text-right">Question marquées</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr each={evaluations.in_progress}>
                                <td class="v-align">{name}</td>
                                <td class="v-align">{dateFormatFr(start_date)}</td>
                                <td class="v-align">{dateFormatFr(end_date)}</td>
                                <td class="v-align">{(duration == '00:00:00') ? 'Illimité' : duration }</td>
                                <td class="text-right v-align">?</td>
                                <td class="text-right v-align">?</td>
                                <td class="text-right">
                                    <a href=""><button id="template-add-button" class="btn btn-warning"><i id="template-add-button-ico" class="fa fa-pencil"></i> Reprendre</button></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            </div>
        </div>
    </div>
    <hr>
    <div class="row text-center">
        <a href=""><button id="template-add-button" class="btn btn-success"><i id="template-add-button-ico" class="fa fa-search fa-2X"></i> <label class="v-align">Voir mes resultat</label></button></a>
    </div>
    
    <script>
        var self = this;
        self.evaluations = { in_progress : [], available : []};
        self.inProgressEvaluations = {};
        
        loader.hide();
        loader.show('#evaluations-available-loader');
        
        this.on('mount',function(){
            opts.auth.getEvaluations('available');
            opts.auth.getEvaluations('in_progress');
        });
        
        //-----------------
        //SLOTS ----------
        //-----------------
        opts.auth.on('account_evaluations_available', function(json){
            self.evaluations.available = json.data;
            self.update();
            
            loader.hide('#evaluations-available-loader');
            $('#evaluations-available-content').show();
        });
        
        opts.auth.on('account_evaluations_in_progress', function(json){
            self.evaluations.in_progress = json.data;
            self.update();
            
            loader.hide('#evaluations-in-progress-loader');
            $('#evaluations-in-progress-content').show();
        });
        
    </script>
</evaluations>