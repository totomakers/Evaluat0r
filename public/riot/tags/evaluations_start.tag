<evaluations_start>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12 text-right">
                <a href="#evaluations"><button type="button" class="btn btn-danger btn-lg text-right"><i class="fa fa-close fa-lg v-align"></i> Quitter</button></a>
            </div> 
        </div>
        <hr>
        <div id="alert-box">
        </div>
        <div class="row">
            <div class="col-lg-12 animated bounceInUp">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h1 class="panel-title">Informations</h1>
                    </div>
                    <div class="panel-body">
                        <ul>
                            <li>Vous êtes sur le point de démarrer le QCM <span class="text-primary">{session.name}</span> composé de <span class="text-primary">{session.question_count}</span> question(s)</li>
                            <li>Le test est disponible du <span class="text-primary">{dateFormatFr(session.start_date)}</span> au <span class="text-primary">{dateFormatFr(session.end_date)}</span>.</li>
                            <li show={session.duration != '00:00:00'}>Vous disposez de <span class="text-primary">{session.duration}</span> pour effectuer ce test.</li>
                            <li show={session.duration == '00:00:00'}>Vous n'avez aucune limite de temps pour repondre au test.</li>
                            <li>Le nombre de réponse possible est indiqué dans le titre de la question.</li>
                            <li>Le bouton <span class="label label-danger">Quitter</span> permet de retourner a la liste des tests.</li>
                        </ul>
                        <hr>
                        <h4 class="text-center"><span class="label label-warning"><i class="fa fa-exclamation-triangle"></i> En cliquant sur "Démarrer l'examen", le chronomètre seras activé et votre examen débuteras.</span></h4>
                        <hr>
                        <div class="text-center">
                            <button class="btn btn-primary btn-lg" onclick={evaluation_start}>Démarrer l'examen</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        self.session;
        loader.hide();
        
        this.on('mount', function(){
            opts.session.get(opts.page.id);
        })
        
        evaluation_start(e){
            opts.evaluation.start(opts.page.id);
        }
        
        opts.session.on('session_get', function(json)
        {
            self.session = json.data;
            self.update();
        });
        
        opts.evaluation.on('evaluation_start', function(json)
        {
            alert.show('#alert-box', (json.error == false) ? 'success' : 'danger', json.message);
            self.update();
            
            if(json.error == false) riot.route('evaluations/exam/'+json.data.id);
        }); 
    </script>
</evaluations_start>