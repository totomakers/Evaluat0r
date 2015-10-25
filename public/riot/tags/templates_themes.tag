<templates_themes>
    <div id="subloader" class="center-block">
        <i class="fa fa-spinner fa-spin fa-3x"></i>
    </div>
    <div class="row" hidden>
        <div class="col-lg-12">
            <h1>Test d'admission <small>durée 1:00h</small></h1>
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h2>Thèmes <small>3</small></h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="table">
                <table class="table table-striped table-hover">
                    <thead>
                        <th>Thèmes</th>
                        <th>Nombre de questions ?</th>
                        <th>Actions</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" class="form-control" id="modele_theme_name" placeholder="Votre thème"></input></td>
                            <td><input type="text" class="form-control" id="modele_theme_questions_count" placeholder="Nombre de question"></input></td>
                            <td><button id="model_theme_add_button" class="btn btn-success btn-lg" onclick={models_add}><i id="model_theme_button_ico" class="fa fa-plus fa-lg"></i></button></td>
                        </tr>
                        <tr>
                            <td><a href="">C#</a></td>
                            <td>10 questions</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script>
        var self = this;
    </script>
</templates_themes>