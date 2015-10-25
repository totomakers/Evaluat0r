<modeles>
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12">
                <h1>Modèles</h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-7">
                <div class="table">
                    <table class="table table-striped">
                        <thead>
                            <th></th>
                            <th>Nom</th>
                            <th>Durée du test</th>
                            <th>Admis: % requis</th>
                            <th>En cours d'acquisition: % requis</th>
                            <th>Nombre de thèmes</th>
                            <th>Nombre de question(s) total</th>
                            <th>Actions</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                                <td><input type="text" class="form-control" id="model_add_name" placeholder="Nom"></input></td>
                                <td>
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" value="00:00">
                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                    </div>
                                </td>
                                <td><input type="text" class="form-control" id="model_add_admis" placeholder="15"></input></td>
                                <td><input type="text" class="form-control" id="model_add_admis" placeholder="34"></input></td>
                                <td></td>
                                <td></td>
                                <td><button id="model_add_button" class="btn btn-success btn-lg" onclick={models_add}><i id="models_add_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="currentModel" value="{id}" checked></td>
                                <td>Test d'admission</td>
                                <td>1:00 heures</td>
                                <td><span class="text-success">±85%</span></td>
                                <td><span class="text-warning">±35%</span></td>
                                <td>4</td>
                                <td>50</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="currentModel" value="{id_2}"></td>
                                <td>Test d'admission</td>
                                <td>1:00 heures</td>
                                <td><span class="text-success">±85%</span></td>
                                <td><span class="text-warning">±35%</span></td>
                                <td>4</td>
                                <td>50</td>
                                <td></td>
                            <t/r>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-lg-5" class="animated fadeIn">
                <modeles_themes>
                </modeles_themes>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
        loader.show();
        
        this.on('mount',function() {
            $('.clockpicker').clockpicker({
                    donetext: 'Valider',
                    default: '00:00',
                    placement: 'bottom',
                    //align: 'top',
            });   

            loader.hide();            
        });
    </script>
</modeles>