<evalutions_details>
    <div class="row">
        <div class="row">
             <div class="col-lg-12">
                <div class="col-lg-2">
                    <h3>TIMER</h3>
                </div>
                <div class="col-lg-8">
                    <!-- LINKED NAV -->
                    <div class="text-center">
                        <ol class="carousel-linked-nav pagination">
                          <li class="active" id="1"><a href="#1">1</a></li>
                          <li><a href="#2" id="2">2</a></li>
                          <li><a href="#3" id="3">3</a></li>
                        </ol>
                    </div>
                </div>
                <div class="col-lg-2">
                    <button type="button" class="btn btn-danger btn-lg text-right"><i class="fa fa-close fa-lg v-align"></i> Quitter</button>
                </div> 
             </div>
        </div>
        <hr>
        <div class="col-lg-12">
            <div class="col-lg-2">
            </div>
            <div class="col-lg-8">
                <div id="carousel" class="carousel slide" data-ride="carousel">
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <!-- /!\ Attention pour le bon fonctionnent il faut le premiere question en class="item active" /!\ --> 
                        <div class="item active">
                            <h3>Ici, ce trouve la question qu'on récupère de la BDD</h3>
                            <p>Ici pour pas une image ??</p>
                            <p>Où encore un bout de code :)</p>
                            <hr>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse1">
                                    <label for="reponse1">
                                        Réponse 1
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse2">
                                    <label for="reponse2">
                                        Réponse 2
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse3">
                                    <label for="reponse3">
                                        Réponse 3
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse4">
                                    <label for="reponse4">
                                        Réponse 4
                                    </label>
                                </div>
                            </div>
                            <div class="row text-center">
                                <button type="button" class="btn btn-warning" onclick={answer_marqued}>Marquer</button>
                                <button type="button" class="btn btn-success" onclick={answer_validate}>Valider</button>
                            </div>
                        </div>
                         <!-- /!\ ici on ne met plus la classe item active mais seulement item /!\ -->
                        <div class="item">
                            <h3>Ici, ce trouve la question numéro 2 qu'on récupère de la BDD</h3>
                            <p>Ici on pourrait mettre une image, ou deux, ou trois , ou .. bon OK j'arrête</p>
                            <p>Où encore un bout de code, ou deux, ou trois , ou QUOI ??????</p>
                            <hr>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse1">
                                    <label for="reponse1">
                                        Réponse 1
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse2">
                                    <label for="reponse2">
                                        Réponse 2
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse3">
                                    <label for="reponse3">
                                        Réponse 3
                                    </label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="checkbox checkbox-success">
                                    <input type="checkbox" id="reponse4">
                                    <label for="reponse4">
                                        Réponse 4
                                    </label>
                                </div>
                            </div>
                            <div class="row text-center">
                                <button type="button" class="btn btn-warning" onclick={answer_marqued}>Marquer</button>
                                <button type="button" class="btn btn-success" onclick={answer_validate}>Valider</button>
                            </div>
                        </div>
                        <div class="item">
                            <div class="text-center">
                                <h3>Vous avez terminé le test</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-2">
            </div>
        </div>
    </div>
    <script>
    loader.hide();
    
     this.on('mount',function() {
        $('.carousel').carousel({
            wrap: false,
            interval:false,
        })
        
        /* SLIDE ON CLICK */ 
        $('.carousel-linked-nav > li > a').click(function() {

            // saisir href , retirez signe dièse , convertir en nombre
            var item = Number($(this).attr('href').substring(1));

            // glisser au numéro 1 ( compte pour l'indexation zéro)
            $('#carousel').carousel(item - 1);

            // retirer classe active actuelle
            $('.carousel-linked-nav .active').removeClass('active');

            // ajouter classe active juste cliqué sur le point
            $(this).parent().addClass('active');

            // ne pas suivre le lien
            return false;
        });
    });   
    
    //---------------
    // Link modifier
    //---------------
    answer_validate(e){
        $('.carousel-linked-nav .active').addClass('active');
    }
    
    answer_marqued(e){
        $('.carousel-linked-nav > li  .active').addClass('btn btn-warning');
    }
    </script>
</evalutions_details>