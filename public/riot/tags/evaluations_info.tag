<evaluations_info>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12 text-right">
                <a href="#evaluations"><button type="button" class="btn btn-danger btn-lg text-right"><i class="fa fa-close fa-lg v-align"></i> Quitter</button></a>
            </div> 
        </div>
        <hr>
        <div class="row">
            <div class="col-lg-12 animated bounceInUp">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h1 class="panel-title">Informations</h1>
                    </div>
                    <div class="panel-body">
                        <ul>
                            <li>Vous êtes sur le point de démarrer le QCM #name composé de n question(s)</li>
                            <li>Le test est disponible du 01/01/05 au 01/01/05.</li>
                            <li>Vous disposez de 00:00h pour effectuer ce test.</li>
                            <li>Vous n'avez aucune limite de temps pour repondre au test.</li>
                            <li>Le nombre de réponse possible est indiqué dans le titre de la question.</li>
                            <li>Le bouton <span class="label label-danger">Quitter</span> permet de retourner a la liste des tests.</li>
                        </ul>
                        <hr>
                        <h4 class="text-center"><span class="label label-warning"><i class="fa fa-exclamation-triangle"></i> En cliquant sur "Lancer", le chronomètre seras activé et votre examen débuteras.</span></h4>
                        <hr>
                        <div class="text-center">
                            <button class="btn btn-primary btn-lg" onclick={evaluation_start}>Démarrer l'examen !</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
    </script>
</evaluations_info>